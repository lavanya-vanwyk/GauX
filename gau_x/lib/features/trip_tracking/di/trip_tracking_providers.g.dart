// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_tracking_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(trackingRepository)
final trackingRepositoryProvider = TrackingRepositoryProvider._();

final class TrackingRepositoryProvider
    extends
        $FunctionalProvider<
          TrackingRepository,
          TrackingRepository,
          TrackingRepository
        >
    with $Provider<TrackingRepository> {
  TrackingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trackingRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trackingRepositoryHash();

  @$internal
  @override
  $ProviderElement<TrackingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TrackingRepository create(Ref ref) {
    return trackingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TrackingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TrackingRepository>(value),
    );
  }
}

String _$trackingRepositoryHash() =>
    r'1c975a151484911f6b1172f50f2c5bd01484754c';

/// Supplied by the app layer (see `lib/app/app_overrides.dart`), which
/// connects it to the wallet.

@ProviderFor(tripPaymentPort)
final tripPaymentPortProvider = TripPaymentPortProvider._();

/// Supplied by the app layer (see `lib/app/app_overrides.dart`), which
/// connects it to the wallet.

final class TripPaymentPortProvider
    extends
        $FunctionalProvider<TripPaymentPort, TripPaymentPort, TripPaymentPort>
    with $Provider<TripPaymentPort> {
  /// Supplied by the app layer (see `lib/app/app_overrides.dart`), which
  /// connects it to the wallet.
  TripPaymentPortProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tripPaymentPortProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tripPaymentPortHash();

  @$internal
  @override
  $ProviderElement<TripPaymentPort> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TripPaymentPort create(Ref ref) {
    return tripPaymentPort(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TripPaymentPort value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TripPaymentPort>(value),
    );
  }
}

String _$tripPaymentPortHash() => r'45f2096fc9c5631ab97e89d572191c3798e1ae8c';

@ProviderFor(completeTrip)
final completeTripProvider = CompleteTripProvider._();

final class CompleteTripProvider
    extends $FunctionalProvider<CompleteTrip, CompleteTrip, CompleteTrip>
    with $Provider<CompleteTrip> {
  CompleteTripProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'completeTripProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$completeTripHash();

  @$internal
  @override
  $ProviderElement<CompleteTrip> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CompleteTrip create(Ref ref) {
    return completeTrip(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CompleteTrip value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CompleteTrip>(value),
    );
  }
}

String _$completeTripHash() => r'd0431539370c7dca16662891d15413faa93f8f4b';

@ProviderFor(cancelTrip)
final cancelTripProvider = CancelTripProvider._();

final class CancelTripProvider
    extends $FunctionalProvider<CancelTrip, CancelTrip, CancelTrip>
    with $Provider<CancelTrip> {
  CancelTripProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cancelTripProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cancelTripHash();

  @$internal
  @override
  $ProviderElement<CancelTrip> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CancelTrip create(Ref ref) {
    return cancelTrip(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CancelTrip value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CancelTrip>(value),
    );
  }
}

String _$cancelTripHash() => r'f491b3c0185d0f37d17ee2ba3d156b90216aab85';
