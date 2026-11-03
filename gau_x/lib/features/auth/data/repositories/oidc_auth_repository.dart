import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../../core/domain/failure.dart';
import '../../../../core/domain/result.dart';
import '../../../../core/storage/secure_cache.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../oidc/oidc_client.dart';

/// Signs in with Keycloak and keeps the tokens in secure storage, so the
/// rider stays signed in across launches. Access tokens are short-lived and
/// refreshed shortly before they expire.
class OidcAuthRepository implements AuthRepository {
  OidcAuthRepository({
    required OidcClient? client,
    required SecureCache storage,
    this.refreshMargin = const Duration(seconds: 30),
    DateTime Function()? clock,
  }) : _client = client,
       _storage = storage,
       _clock = clock ?? DateTime.now;

  static const _storageKey = 'auth_tokens_v1';

  /// Null when the build has no identity provider configured.
  final OidcClient? _client;
  final SecureCache _storage;
  final Duration refreshMargin;
  final DateTime Function() _clock;

  TokenSet? _tokens;
  Future<String?>? _refreshing;

  @override
  Future<Result<AuthSession>> signIn() async {
    final client = _client;
    if (client == null) {
      return const Err(SignInUnavailableFailure('No identity provider'));
    }
    try {
      final tokens = await client.signIn();
      await _save(tokens);
      return Success(_sessionFrom(tokens));
    } on OidcCancelledException {
      return const Err(SignInCancelledFailure('Login page closed'));
    } on Exception catch (e) {
      return Err(NetworkFailure('Sign-in failed: $e'));
    }
  }

  @override
  Future<AuthSession?> restore() async {
    final tokens = await _load();
    if (tokens == null) return null;
    // Make sure the saved session still works before calling it signed in
    if (await accessToken() == null) return null;
    return _sessionFrom(_tokens ?? tokens);
  }

  @override
  Future<String?> accessToken() async {
    final tokens = _tokens ?? await _load();
    if (tokens == null) return null;
    final fresh = _clock()
        .add(refreshMargin)
        .isBefore(tokens.accessTokenExpiresAt);
    if (fresh) return tokens.accessToken;
    // One refresh at a time; concurrent callers share it
    return _refreshing ??= _refresh(
      tokens,
    ).whenComplete(() => _refreshing = null);
  }

  @override
  Future<void> signOut() async {
    final tokens = _tokens ?? await _load();
    _tokens = null;
    await _storage.delete(_storageKey);
    await _client?.signOut(idToken: tokens?.idToken);
  }

  Future<String?> _refresh(TokenSet tokens) async {
    final client = _client;
    final refreshToken = tokens.refreshToken;
    if (client == null || refreshToken == null) {
      await _forget();
      return null;
    }
    try {
      final refreshed = await client.refresh(refreshToken);
      await _save(
        // Keycloak may not return a new ID token on refresh; keep the old one
        TokenSet(
          accessToken: refreshed.accessToken,
          accessTokenExpiresAt: refreshed.accessTokenExpiresAt,
          refreshToken: refreshed.refreshToken ?? refreshToken,
          idToken: refreshed.idToken ?? tokens.idToken,
        ),
      );
      return refreshed.accessToken;
    } on Exception catch (e) {
      // The session has ended (logged out elsewhere, expired, revoked)
      debugPrint('Auth: refresh failed, signing out ($e)');
      await _forget();
      return null;
    }
  }

  AuthSession _sessionFrom(TokenSet tokens) {
    final claims = tokens.idClaims;
    return AuthSession(
      userId: claims['sub'] as String? ?? '',
      email: claims['email'] as String?,
      name: claims['name'] as String?,
    );
  }

  Future<void> _save(TokenSet tokens) async {
    _tokens = tokens;
    await _storage.write(_storageKey, jsonEncode(tokens.toJson()));
  }

  Future<void> _forget() async {
    _tokens = null;
    await _storage.delete(_storageKey);
  }

  Future<TokenSet?> _load() async {
    final raw = await _storage.read(_storageKey);
    if (raw == null) return null;
    try {
      return _tokens = TokenSet.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
    } on Object {
      await _storage.delete(_storageKey);
      return null;
    }
  }
}
