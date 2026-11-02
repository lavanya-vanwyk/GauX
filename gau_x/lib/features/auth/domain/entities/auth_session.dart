import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_session.freezed.dart';

/// A signed-in rider, as identified by Keycloak. Tokens are kept by the
/// repository, never in app state.
@freezed
abstract class AuthSession with _$AuthSession {
  const factory AuthSession({
    /// Keycloak's stable user ID (`sub`); the server keys wallets by it.
    required String userId,
    String? email,
    String? name,
  }) = _AuthSession;
}
