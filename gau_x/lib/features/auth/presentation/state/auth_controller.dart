import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/domain/result.dart';
import '../../di/auth_providers.dart';
import '../../domain/entities/auth_session.dart';

part 'auth_controller.g.dart';

/// The signed-in session, or null when signed out. The router listens to
/// this to guard the wallet.
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  AuthSession? build() => null;

  Future<Result<AuthSession>> signIn({
    required String email,
    required String password,
  }) async {
    final result = await ref
        .read(authRepositoryProvider)
        .signIn(email: email, password: password);
    if (result case Success(:final value) when ref.mounted) state = value;
    return result;
  }

  void signOut() => state = null;
}
