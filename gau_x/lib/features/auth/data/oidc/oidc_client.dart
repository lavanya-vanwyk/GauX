import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

/// Tokens from the identity provider.
class TokenSet {
  const TokenSet({
    required this.accessToken,
    required this.accessTokenExpiresAt,
    this.refreshToken,
    this.idToken,
  });

  factory TokenSet.fromJson(Map<String, dynamic> json) => TokenSet(
    accessToken: json['accessToken'] as String,
    accessTokenExpiresAt: DateTime.parse(json['expiresAt'] as String),
    refreshToken: json['refreshToken'] as String?,
    idToken: json['idToken'] as String?,
  );

  final String accessToken;
  final DateTime accessTokenExpiresAt;
  final String? refreshToken;
  final String? idToken;

  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'expiresAt': accessTokenExpiresAt.toUtc().toIso8601String(),
    'refreshToken': refreshToken,
    'idToken': idToken,
  };

  /// Claims from the ID token. Not signature-checked: it came straight from
  /// the provider over TLS and is only used for display (name, email) and
  /// the user ID, which the server independently verifies on every call.
  Map<String, dynamic> get idClaims {
    final token = idToken;
    if (token == null) return const {};
    try {
      final payload = token.split('.')[1];
      return jsonDecode(
            utf8.decode(base64Url.decode(base64Url.normalize(payload))),
          )
          as Map<String, dynamic>;
    } on Object {
      return const {};
    }
  }
}

/// The rider closed the login page.
class OidcCancelledException implements Exception {
  const OidcCancelledException();
}

/// The OAuth2/OIDC calls the app makes. [FlutterAppAuthClient] runs them
/// through the system browser; tests use a fake.
abstract interface class OidcClient {
  /// Authorization Code flow with PKCE in the system browser.
  Future<TokenSet> signIn();

  Future<TokenSet> refresh(String refreshToken);

  Future<void> signOut({String? idToken});
}

class FlutterAppAuthClient implements OidcClient {
  FlutterAppAuthClient({
    required this.issuer,
    required this.clientId,
    required this.redirectUrl,
    FlutterAppAuth appAuth = const FlutterAppAuth(),
  }) : _appAuth = appAuth;

  final String issuer;
  final String clientId;
  final String redirectUrl;
  final FlutterAppAuth _appAuth;

  static const _scopes = ['openid', 'profile', 'email'];

  // Plain http is only for a local dev Keycloak
  bool get _insecure => issuer.startsWith('http://');

  @override
  Future<TokenSet> signIn() async {
    try {
      final response = await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          clientId,
          redirectUrl,
          issuer: issuer,
          scopes: _scopes,
          allowInsecureConnections: _insecure,
        ),
      );
      return _tokens(response);
    } on FlutterAppAuthUserCancelledException {
      throw const OidcCancelledException();
    }
  }

  @override
  Future<TokenSet> refresh(String refreshToken) async {
    final response = await _appAuth.token(
      TokenRequest(
        clientId,
        redirectUrl,
        issuer: issuer,
        refreshToken: refreshToken,
        grantType: GrantType.refreshToken,
        scopes: _scopes,
        allowInsecureConnections: _insecure,
      ),
    );
    return _tokens(response);
  }

  @override
  Future<void> signOut({String? idToken}) async {
    try {
      await _appAuth.endSession(
        EndSessionRequest(
          idTokenHint: idToken,
          postLogoutRedirectUrl: redirectUrl,
          issuer: issuer,
          allowInsecureConnections: _insecure,
        ),
      );
    } on PlatformException {
      // Best effort: the local tokens are gone either way
    }
  }

  static TokenSet _tokens(TokenResponse response) => TokenSet(
    accessToken: response.accessToken!,
    accessTokenExpiresAt:
        response.accessTokenExpirationDateTime ??
        DateTime.now().add(const Duration(minutes: 5)),
    refreshToken: response.refreshToken,
    idToken: response.idToken,
  );
}
