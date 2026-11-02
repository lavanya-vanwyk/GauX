// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(rideTimings)
final rideTimingsProvider = RideTimingsProvider._();

final class RideTimingsProvider
    extends $FunctionalProvider<RideTimings, RideTimings, RideTimings>
    with $Provider<RideTimings> {
  RideTimingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rideTimingsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rideTimingsHash();

  @$internal
  @override
  $ProviderElement<RideTimings> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RideTimings create(Ref ref) {
    return rideTimings(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RideTimings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RideTimings>(value),
    );
  }
}

String _$rideTimingsHash() => r'21c10fbc81bfaab2c6f5d78c3409e1ceb3180caf';

/// Runs an active ride through its phases and charges the rider on arrival
/// or cancellation.

@ProviderFor(RideController)
final rideControllerProvider = RideControllerProvider._();

/// Runs an active ride through its phases and charges the rider on arrival
/// or cancellation.
final class RideControllerProvider
    extends $NotifierProvider<RideController, RideState> {
  /// Runs an active ride through its phases and charges the rider on arrival
  /// or cancellation.
  RideControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rideControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rideControllerHash();

  @$internal
  @override
  RideController create() => RideController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RideState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RideState>(value),
    );
  }
}

String _$rideControllerHash() => r'39109129aa0ef2434f82ee468b1f98501689933f';

/// Runs an active ride through its phases and charges the rider on arrival
/// or cancellation.

abstract class _$RideController extends $Notifier<RideState> {
  RideState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<RideState, RideState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RideState, RideState>,
              RideState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
