import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaux_contracts/gaux_contracts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config.dart';
import '../di/core_providers.dart';
import '../domain/result.dart';
import 'remote_config_repository.dart';

part 'remote_config_providers.g.dart';

@Riverpod(keepAlive: true)
RemoteConfigRepository remoteConfigRepository(Ref ref) =>
    RemoteConfigRepository(
      prefs: ref.watch(sharedPreferencesProvider),
      client: AppConfig.usesGauxApi ? ref.watch(apiClientProvider) : null,
      baseUrl: AppConfig.gauxApiBaseUrl,
    );

/// The config the app runs with. Starts from the cached copy (or defaults)
/// so nothing waits on the network, then refreshes in the background.
@Riverpod(keepAlive: true)
class RemoteConfigController extends _$RemoteConfigController {
  @override
  RemoteConfig build() {
    final repository = ref.watch(remoteConfigRepositoryProvider);
    unawaited(refresh());
    return repository.cached();
  }

  /// Fetches the latest document. Keeps the current config on failure.
  Future<void> refresh() async {
    final result = await ref.read(remoteConfigRepositoryProvider).refresh();
    if (!ref.mounted) return;
    switch (result) {
      case Success(:final value):
        if (value != state) state = value;
      case Err(:final failure):
        debugPrint('Remote config: keeping current ($failure)');
    }
  }
}

/// Kill switches from the remote config.
@Riverpod(keepAlive: true)
FeatureFlags featureFlags(Ref ref) =>
    ref.watch(remoteConfigControllerProvider.select((c) => c.flags));
