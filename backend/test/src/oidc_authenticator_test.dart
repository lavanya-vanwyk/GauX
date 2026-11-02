import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:gaux_backend/gaux_backend.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:jose/jose.dart';
import 'package:test/test.dart';

const _issuer = 'https://auth.test/realms/gaux';

/// An RSA signing key with key ID [kid], and its public half.
({JsonWebKey private, Map<String, dynamic> public}) _rsaKey(String kid) {
  final generated = JsonWebKey.generate('RS256', keyBitLength: 2048);
  final json = {
    ...generated.toJson(),
    'kid': kid,
    'alg': 'RS256',
    'use': 'sig',
  };
  return (
    private: JsonWebKey.fromJson(json),
    public: {
      for (final e in json.entries)
        if (!const {'d', 'p', 'q', 'dp', 'dq', 'qi'}.contains(e.key))
          e.key: e.value,
    },
  );
}

void main() {
  final now = DateTime.utc(2026, 11, 2, 12);
  int seconds(DateTime t) => t.millisecondsSinceEpoch ~/ 1000;

  late ({JsonWebKey private, Map<String, dynamic> public}) key;
  late List<Map<String, dynamic>> published;
  late int jwksFetches;
  late DateTime clockNow;
  late OidcAuthenticator authenticator;

  setUp(() {
    key = _rsaKey('k1');
    published = [key.public];
    jwksFetches = 0;
    clockNow = now;
    authenticator = OidcAuthenticator(
      issuer: _issuer,
      audience: 'gaux-api',
      httpClient: MockClient((request) async {
        jwksFetches++;
        expect(request.url.path, '/realms/gaux/protocol/openid-connect/certs');
        return http.Response(jsonEncode({'keys': published}), 200);
      }),
      clock: () => clockNow,
    );
  });

  String token({
    JsonWebKey? signWith,
    Map<String, Object?> overrides = const {},
  }) {
    final claims = <String, Object?>{
      'iss': _issuer,
      'aud': ['gaux-api', 'account'],
      'sub': 'rider-123',
      'typ': 'Bearer',
      'iat': seconds(now),
      'exp': seconds(now.add(const Duration(minutes: 5))),
      ...overrides,
    }..removeWhere((_, v) => v == null);
    final builder = JsonWebSignatureBuilder()
      ..jsonContent = claims
      ..addRecipient(signWith ?? key.private, algorithm: 'RS256');
    return builder.build().toCompactSerialization();
  }

  test('accepts a valid token and returns its subject', () async {
    expect(await authenticator.verify(token()), 'rider-123');
  });

  test('also accepts a single-string audience', () async {
    expect(
      await authenticator.verify(token(overrides: {'aud': 'gaux-api'})),
      'rider-123',
    );
  });

  group('rejects', () {
    final cases = <String, Map<String, Object?>>{
      'an expired token': {
        'exp': seconds(now.subtract(const Duration(minutes: 2))),
      },
      'a token with no expiry': {'exp': null},
      'a token not valid yet': {
        'nbf': seconds(now.add(const Duration(minutes: 5))),
      },
      'another issuer': {'iss': 'https://evil.test/realms/gaux'},
      'another audience': {'aud': 'some-other-api'},
      'an ID token': {'typ': 'ID'},
      'a token with no subject': {'sub': null},
    };
    for (final MapEntry(key: name, value: overrides) in cases.entries) {
      test(name, () async {
        expect(await authenticator.verify(token(overrides: overrides)), isNull);
      });
    }

    test('a token whose claims were edited after signing', () async {
      final parts = token().split('.');
      final forgedClaims = base64Url
          .encode(
            utf8.encode(
              jsonEncode({
                'iss': _issuer,
                'aud': 'gaux-api',
                'sub': 'someone-else',
                'exp': seconds(now.add(const Duration(hours: 1))),
              }),
            ),
          )
          .replaceAll('=', '');

      expect(
        await authenticator.verify('${parts[0]}.$forgedClaims.${parts[2]}'),
        isNull,
      );
    });

    test('a token signed by a key the provider never published', () async {
      final attacker = _rsaKey('k1'); // same key ID, different key

      expect(
        await authenticator.verify(token(signWith: attacker.private)),
        isNull,
      );
    });

    test('an unsigned token (alg: none)', () async {
      String b64(Object json) =>
          base64Url.encode(utf8.encode(jsonEncode(json))).replaceAll('=', '');
      final unsigned =
          '${b64({'alg': 'none', 'kid': 'k1'})}.'
          '${b64({
            'iss': _issuer,
            'aud': 'gaux-api',
            'sub': 'x',
            'exp': seconds(now) + 300,
          })}.';

      expect(await authenticator.verify(unsigned), isNull);
    });

    test('things that are not JWTs', () async {
      for (final junk in ['', 'abc', 'a.b.c', 'dev:rider']) {
        expect(await authenticator.verify(junk), isNull, reason: junk);
      }
    });
  });

  group('signing keys', () {
    test('are fetched once and cached', () async {
      await authenticator.verify(token());
      await authenticator.verify(token());

      expect(jwksFetches, 1);
    });

    test('are refetched when Keycloak rotates to a new key', () async {
      await authenticator.verify(token());
      final rotated = _rsaKey('k2');
      published = [rotated.public];
      clockNow = now.add(const Duration(minutes: 2));

      expect(
        await authenticator.verify(token(signWith: rotated.private)),
        'rider-123',
      );
      expect(jwksFetches, 2);
    });

    test('unknown key IDs cannot make us hammer Keycloak', () async {
      await authenticator.verify(token());
      final unknown = _rsaKey('nope');
      for (var i = 0; i < 5; i++) {
        await authenticator.verify(token(signWith: unknown.private));
      }

      expect(jwksFetches, 1, reason: 'at most one refetch per minute');
    });
  });

  test('reads the bearer token from the request', () async {
    final request = Request.get(
      Uri.parse('http://localhost/v1/wallet'),
      headers: {'authorization': 'Bearer ${token()}'},
    );

    expect(await authenticator.userId(request), 'rider-123');
  });

  test('FirstOfAuthenticator falls through to dev tokens', () async {
    final both = FirstOfAuthenticator([
      authenticator,
      const DevAuthenticator(),
    ]);

    expect(
      await both.userId(
        Request.get(
          Uri.parse('http://localhost/'),
          headers: {'authorization': 'Bearer dev:alice'},
        ),
      ),
      'alice',
    );
  });
}
