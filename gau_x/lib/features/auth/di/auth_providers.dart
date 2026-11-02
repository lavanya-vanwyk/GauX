import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/app_config.dart';
import '../../../core/di/core_providers.dart';
import '../data/oidc/oidc_client.dart';
import '../data/repositories/oidc_auth_repository.dart';
import '../domain/repositories/auth_repository.dart';

part 'auth_providers.g.dart';

/// The identity provider client, or null when the build has none configured.
@Riverpod(keepAlive: true)
OidcClient? oidcClient(Ref ref) => AppConfig.oidcIssuer.isEmpty
    ? null
    : FlutterAppAuthClient(
        issuer: AppConfig.oidcIssuer,
        clientId: AppConfig.oidcClientId,
        redirectUrl: AppConfig.oidcRedirectUrl,
      );

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => OidcAuthRepository(
  client: ref.watch(oidcClientProvider),
  storage: ref.watch(secureCacheProvider),
  clock: ref.watch(clockProvider),
);
