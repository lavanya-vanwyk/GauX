// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_config_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(remoteConfigRepository)
final remoteConfigRepositoryProvider = RemoteConfigRepositoryProvider._();

final class RemoteConfigRepositoryProvider
    extends
        $FunctionalProvider<
          RemoteConfigRepository,
          RemoteConfigRepository,
          RemoteConfigRepository
        >
    with $Provider<RemoteConfigRepository> {
  RemoteConfigRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteConfigRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remoteConfigRepositoryHash();

  @$internal
  @override
  $ProviderElement<RemoteConfigRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RemoteConfigRepository create(Ref ref) {
    return remoteConfigRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemoteConfigRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemoteConfigRepository>(value),
    );
  }
}

String _$remoteConfigRepositoryHash() =>
    r'64f0a8b7c99d7dd1aec0cc50df94b54c466947e5';

/// The config the app runs with. Starts from the cached copy (or defaults)
/// so nothing waits on the network, then refreshes in the background.

@ProviderFor(RemoteConfigController)
final remoteConfigControllerProvider = RemoteConfigControllerProvider._();

/// The config the app runs with. Starts from the cached copy (or defaults)
/// so nothing waits on the network, then refreshes in the background.
final class RemoteConfigControllerProvider
    extends $NotifierProvider<RemoteConfigController, RemoteConfig> {
  /// The config the app runs with. Starts from the cached copy (or defaults)
  /// so nothing waits on the network, then refreshes in the background.
  RemoteConfigControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteConfigControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remoteConfigControllerHash();

  @$internal
  @override
  RemoteConfigController create() => RemoteConfigController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemoteConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemoteConfig>(value),
    );
  }
}

String _$remoteConfigControllerHash() =>
    r'3eac4c245acafd628e24236a0c92b3e891484e9b';

/// The config the app runs with. Starts from the cached copy (or defaults)
/// so nothing waits on the network, then refreshes in the background.

abstract class _$RemoteConfigController extends $Notifier<RemoteConfig> {
  RemoteConfig build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<RemoteConfig, RemoteConfig>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RemoteConfig, RemoteConfig>,
              RemoteConfig,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Kill switches from the remote config.

@ProviderFor(featureFlags)
final featureFlagsProvider = FeatureFlagsProvider._();

/// Kill switches from the remote config.

final class FeatureFlagsProvider
    extends $FunctionalProvider<FeatureFlags, FeatureFlags, FeatureFlags>
    with $Provider<FeatureFlags> {
  /// Kill switches from the remote config.
  FeatureFlagsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'featureFlagsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$featureFlagsHash();

  @$internal
  @override
  $ProviderElement<FeatureFlags> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FeatureFlags create(Ref ref) {
    return featureFlags(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FeatureFlags value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FeatureFlags>(value),
    );
  }
}

String _$featureFlagsHash() => r'7e6dacaa8421a5fdc9d70d378936a7c035f6b160';
