import '../../../../core/domain/failure.dart';
import '../../../../core/domain/result.dart';
import '../entities/auth_session.dart';

/// The email and password don't match an account.
final class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure(super.message);
}

/// This build can't sign anyone in (e.g. a prod build before real auth).
final class SignInUnavailableFailure extends Failure {
  const SignInUnavailableFailure(super.message);
}

abstract interface class AuthRepository {
  Future<Result<AuthSession>> signIn({
    required String email,
    required String password,
  });
}
