import 'dart:async';
import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:gaux_backend/src/auth/authenticator.dart';
import 'package:http/http.dart' as http;
import 'package:jose/jose.dart';

/// Accepts access tokens issued by an OpenID Connect provider (Keycloak).
///
/// A token is accepted only if its RS256 signature matches one of the
/// provider's published keys and it was issued by [issuer], for [audience],
/// and hasn't expired. The rider's ID is the token's `sub` claim.
///
/// Keys are fetched from [jwksUrl] and cached. A token signed with a key ID
/// we haven't seen triggers a refetch (at most once per
/// [minRefetchInterval]), so key rotation in Keycloak just works.
class OidcAuthenticator implements Authenticator {
  OidcAuthenticator({
    required this.issuer,
    required this.audience,
    Uri? jwksUrl,
    http.Client? httpClient,
    this.leeway = const Duration(seconds: 30),
    this.minRefetchInterval = const Duration(minutes: 1),
    DateTime Function()? clock,
  }) : jwksUrl = jwksUrl ?? Uri.parse('$issuer/protocol/openid-connect/certs'),
       _http = httpClient ?? http.Client(),
       _clock = clock ?? DateTime.now;

  /// e.g. `https://auth.gaux.co.za/realms/gaux`. Must match `iss` exactly.
  final String issuer;

  /// The API's client ID in the provider, which tokens must name in `aud`.
  final String audience;
  final Uri jwksUrl;

  /// Allowance for clock differences between the provider and this server.
  final Duration leeway;
  final Duration minRefetchInterval;

  final http.Client _http;
  final DateTime Function() _clock;

  // Only RS256: never accept "none" or symmetric algorithms
  static const _allowedAlgorithms = ['RS256'];

  Map<String, JsonWebKey> _keys = const {};
  DateTime? _lastFetch;
  Future<void>? _fetching;

  @override
  Future<String?> userId(Request request) async {
    final header = request.headers['authorization'];
    if (header == null || !header.startsWith('Bearer ')) return null;
    return verify(header.substring('Bearer '.length).trim());
  }

  /// The token's subject if it's valid, otherwise null.
  Future<String?> verify(String token) async {
    final JsonWebToken unverified;
    try {
      unverified = JsonWebToken.unverified(token);
    } on Object {
      return null; // Not a JWT at all
    }

    final keyId = _keyIdOf(token);
    if (keyId == null) return null;
    final key = await _key(keyId);
    if (key == null) return null;

    final store = JsonWebKeyStore()..addKey(key);
    if (!await unverified.verify(store, allowedArguments: _allowedAlgorithms)) {
      return null;
    }
    return _subjectIfValid(unverified.claims);
  }

  /// The `kid` from the token's (not yet trusted) header.
  static String? _keyIdOf(String token) {
    try {
      final header = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(token.split('.')[0]))),
      );
      return header is Map<String, dynamic> ? header['kid'] as String? : null;
    } on Object {
      return null;
    }
  }

  String? _subjectIfValid(JsonWebTokenClaims claims) {
    final now = _clock();
    final expiry = claims.expiry;
    if (expiry == null || now.isAfter(expiry.add(leeway))) return null;
    final notBefore = claims.notBefore;
    if (notBefore != null && now.add(leeway).isBefore(notBefore)) return null;
    final issuedAt = claims.issuedAt;
    if (issuedAt != null && now.add(leeway).isBefore(issuedAt)) return null;

    if (claims.issuer?.toString() != issuer) return null;
    if (!(claims.audience ?? const []).contains(audience)) return null;
    // Keycloak marks access tokens "Bearer"; this rejects ID and refresh
    // tokens even if they were somehow issued for our audience
    final type = claims['typ'];
    if (type != null && type != 'Bearer') return null;

    final subject = claims.subject;
    return subject == null || subject.isEmpty ? null : subject;
  }

  Future<JsonWebKey?> _key(String keyId) async {
    if (_keys[keyId] case final key?) return key;

    final last = _lastFetch;
    final mayRefetch =
        last == null || _clock().difference(last) >= minRefetchInterval;
    if (mayRefetch) await (_fetching ??= _fetchKeys());
    return _keys[keyId];
  }

  Future<void> _fetchKeys() async {
    try {
      _lastFetch = _clock();
      final response = await _http
          .get(jwksUrl)
          .timeout(const Duration(seconds: 10));
      if (response.statusCode != 200) return;
      final set = JsonWebKeySet.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
      _keys = {
        for (final key in set.keys)
          if (key.keyId != null) key.keyId!: key,
      };
    } on Object {
      // Keep the keys we had; the next unknown key ID retries later
    } finally {
      _fetching = null;
    }
  }
}

/// Tries each authenticator in turn and returns the first user found. Lets
/// development tokens work alongside real ones on a dev server.
class FirstOfAuthenticator implements Authenticator {
  const FirstOfAuthenticator(this._authenticators);

  final List<Authenticator> _authenticators;

  @override
  Future<String?> userId(Request request) async {
    for (final authenticator in _authenticators) {
      if (await authenticator.userId(request) case final id?) return id;
    }
    return null;
  }
}
