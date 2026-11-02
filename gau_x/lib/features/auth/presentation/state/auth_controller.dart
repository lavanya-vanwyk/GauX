import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/domain/result.dart';
import '../../di/auth_providers.dart';
import '../../domain/entities/auth_session.dart';

part 'auth_controller.g.dart';

/// The signed-in session, or null when signed out. The router listens to
/// this to guard the wallet. A session saved from the last launch is
/// restored in the background on start-up.
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  AuthSession? build() {
    unawaited(_restore());
    return null;
  }

  Future<void> _restore() async {
    final session = await ref.read(authRepositoryProvider).restore();
    if (ref.mounted && session != null && state == null) state = session;
  }

  Future<Result<AuthSession>> signIn() async {
    final result = await ref.read(authRepositoryProvider).signIn();
    if (result case Success(:final value) when ref.mounted) state = value;
    return result;
  }

  Future<void> signOut() async {
    state = null;
    await ref.read(authRepositoryProvider).signOut();
  }
}
