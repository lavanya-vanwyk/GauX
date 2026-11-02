import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/app_config.dart';
import '../data/repositories/demo_auth_repository.dart';
import '../domain/repositories/auth_repository.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) =>
    const DemoAuthRepository(enabled: AppConfig.demoLoginEnabled);
