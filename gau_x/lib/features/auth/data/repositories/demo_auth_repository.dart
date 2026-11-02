import '../../../../core/domain/result.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';

/// Accepts only the demo account used for hackathon judging, and only when
/// [enabled]. Replaced by OAuth2/OIDC in Phase 3.
class DemoAuthRepository implements AuthRepository {
  const DemoAuthRepository({
    required this.enabled,
    this.latency = const Duration(milliseconds: 1500),
  });

  static const demoEmail = 'judge@gaux.co.za';
  static const demoPassword = 'Hackathon2026!';

  final bool enabled;

  /// Simulated network delay.
  final Duration latency;

  @override
  Future<Result<AuthSession>> signIn({
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(latency);
    if (!enabled) {
      return const Err(SignInUnavailableFailure('Demo login is disabled'));
    }
    if (email.trim() == demoEmail && password.trim() == demoPassword) {
      return const Success(AuthSession(email: demoEmail));
    }
    return const Err(InvalidCredentialsFailure('Not the demo account'));
  }
}
