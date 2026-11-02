import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gau_x/core/domain/result.dart';
import 'package:gau_x/core/storage/secure_cache.dart';
import 'package:gau_x/features/auth/data/oidc/oidc_client.dart';
import 'package:gau_x/features/auth/data/repositories/oidc_auth_repository.dart';
import 'package:gau_x/features/auth/domain/repositories/auth_repository.dart';

/// A JWT-shaped ID token with [claims] (unsigned; the app only reads it).
String _idToken(Map<String, Object> claims) {
  String part(Object json) =>
      base64Url.encode(utf8.encode(jsonEncode(json))).replaceAll('=', '');
  return '${part({'alg': 'RS256'})}.${part(claims)}.sig';
}

class _FakeOidc implements OidcClient {
  _FakeOidc(this.now);

  DateTime now;
  int refreshes = 0;
  int signOuts = 0;
  bool cancel = false;
  bool refreshFails = false;

  TokenSet _tokens(String access) => TokenSet(
    accessToken: access,
    accessTokenExpiresAt: now.add(const Duration(minutes: 5)),
    refreshToken: 'refresh-$access',
    idToken: _idToken({
      'sub': 'c1e31e81',
      'email': 'judge@gaux.co.za',
      'name': 'Hackathon Judge',
    }),
  );

  @override
  Future<TokenSet> signIn() async {
    if (cancel) throw const OidcCancelledException();
    return _tokens('access-1');
  }

  @override
  Future<TokenSet> refresh(String refreshToken) async {
    refreshes++;
    await Future<void>.delayed(Duration.zero);
    if (refreshFails) {
      throw PlatformException(code: 'invalid_grant', message: 'expired');
    }
    // Keycloak may omit the ID token on refresh
    final next = _tokens('access-${refreshes + 1}');
    return TokenSet(
      accessToken: next.accessToken,
      accessTokenExpiresAt: next.accessTokenExpiresAt,
      refreshToken: next.refreshToken,
    );
  }

  @override
  Future<void> signOut({String? idToken}) async => signOuts++;
}

void main() {
  late DateTime now;
  late _FakeOidc oidc;
  late InMemorySecureCache storage;
  late OidcAuthRepository repository;

  OidcAuthRepository newRepository() =>
      OidcAuthRepository(client: oidc, storage: storage, clock: () => now);

  setUp(() {
    now = DateTime.utc(2026, 11, 2, 12);
    oidc = _FakeOidc(now);
    storage = InMemorySecureCache();
    repository = newRepository();
  });

  test('sign-in returns the session from the ID token', () async {
    final session = (await repository.signIn()).valueOrNull;

    expect(session?.userId, 'c1e31e81');
    expect(session?.email, 'judge@gaux.co.za');
    expect(session?.name, 'Hackathon Judge');
    expect(await repository.accessToken(), 'access-1');
  });

  test('closing the login page is reported as cancelled', () async {
    oidc.cancel = true;

    final result = await repository.signIn();

    expect((result as Err).failure, isA<SignInCancelledFailure>());
  });

  test('without an identity provider, sign-in is unavailable', () async {
    final result = await OidcAuthRepository(
      client: null,
      storage: storage,
    ).signIn();

    expect((result as Err).failure, isA<SignInUnavailableFailure>());
  });

  test('a fresh access token is used as is', () async {
    await repository.signIn();
    now = now.add(const Duration(minutes: 4));

    expect(await repository.accessToken(), 'access-1');
    expect(oidc.refreshes, 0);
  });

  test('an access token about to expire is refreshed', () async {
    await repository.signIn();
    now = now.add(const Duration(minutes: 4, seconds: 45));
    oidc.now = now;

    expect(await repository.accessToken(), 'access-2');
    expect(oidc.refreshes, 1);
  });

  test('simultaneous callers share one refresh', () async {
    await repository.signIn();
    now = now.add(const Duration(minutes: 10));
    oidc.now = now;

    final tokens = await Future.wait([
      for (var i = 0; i < 5; i++) repository.accessToken(),
    ]);

    expect(tokens.toSet(), {'access-2'});
    expect(oidc.refreshes, 1);
  });

  test('a session survives an app restart', () async {
    await repository.signIn();

    final restored = await newRepository().restore();

    expect(restored?.userId, 'c1e31e81');
  });

  test('the ID token is kept when a refresh omits it', () async {
    await repository.signIn();
    now = now.add(const Duration(minutes: 10));
    oidc.now = now;
    await repository.accessToken();

    final restored = await newRepository().restore();

    expect(restored?.email, 'judge@gaux.co.za');
  });

  test('a session that can no longer refresh signs the rider out', () async {
    await repository.signIn();
    now = now.add(const Duration(days: 40));
    oidc.refreshFails = true;

    expect(await repository.accessToken(), isNull);
    expect(await newRepository().restore(), isNull);
  });

  test('signing out forgets the tokens and ends the session', () async {
    await repository.signIn();

    await repository.signOut();

    expect(await repository.accessToken(), isNull);
    expect(await newRepository().restore(), isNull);
    expect(oidc.signOuts, 1);
  });
}
