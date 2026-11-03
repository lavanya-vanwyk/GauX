// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Which station rides start from: the nearest one by GPS, until the rider
/// picks another.

@ProviderFor(StationController)
final stationControllerProvider = StationControllerProvider._();

/// Which station rides start from: the nearest one by GPS, until the rider
/// picks another.
final class StationControllerProvider
    extends $AsyncNotifierProvider<StationController, StationSelection> {
  /// Which station rides start from: the nearest one by GPS, until the rider
  /// picks another.
  StationControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'stationControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$stationControllerHash();

  @$internal
  @override
  StationController create() => StationController();
}

String _$stationControllerHash() => r'a68f559ecc8f5378f3a3242f0aec4a0354056940';

/// Which station rides start from: the nearest one by GPS, until the rider
/// picks another.

abstract class _$StationController extends $AsyncNotifier<StationSelection> {
  FutureOr<StationSelection> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<StationSelection>, StationSelection>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<StationSelection>, StationSelection>,
              AsyncValue<StationSelection>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// The station rides start from right now. While the nearest station is
/// still being found, this is the default station.

@ProviderFor(originStation)
final originStationProvider = OriginStationProvider._();

/// The station rides start from right now. While the nearest station is
/// still being found, this is the default station.

final class OriginStationProvider
    extends
        $FunctionalProvider<GautrainStation, GautrainStation, GautrainStation>
    with $Provider<GautrainStation> {
  /// The station rides start from right now. While the nearest station is
  /// still being found, this is the default station.
  OriginStationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'originStationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$originStationHash();

  @$internal
  @override
  $ProviderElement<GautrainStation> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GautrainStation create(Ref ref) {
    return originStation(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GautrainStation value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GautrainStation>(value),
    );
  }
}

String _$originStationHash() => r'581365e51e7e51707e242c75a49dcf80473f109e';
