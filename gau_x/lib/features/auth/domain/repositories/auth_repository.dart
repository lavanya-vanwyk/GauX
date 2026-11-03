import '../../../../core/domain/failure.dart';
import '../../../../core/domain/result.dart';
import '../entities/auth_session.dart';

/// The rider closed the login page without signing in.
final class SignInCancelledFailure extends Failure {
  const SignInCancelledFailure(super.message);
}

/// This build has no identity provider configured.
final class SignInUnavailableFailure extends Failure {
  const SignInUnavailableFailure(super.message);
}

/// Sign-in through the identity provider (Keycloak).
abstract interface class AuthRepository {
  /// Opens the provider's login page and signs in.
  Future<Result<AuthSession>> signIn();

  /// The session saved from a previous launch, if its tokens still work.
  Future<AuthSession?> restore();

  /// A current access token for API calls, refreshed when about to expire.
  /// Null when signed out or the session can no longer be refreshed.
  Future<String?> accessToken();

  /// Forgets the tokens and ends the provider's session.
  Future<void> signOut();
}
