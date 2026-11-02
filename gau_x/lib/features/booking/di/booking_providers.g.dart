// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The GauX API when the build sets `GAUX_API_BASE_URL`, otherwise the
/// public routing and geocoding services directly.

@ProviderFor(bookingRepository)
final bookingRepositoryProvider = BookingRepositoryProvider._();

/// The GauX API when the build sets `GAUX_API_BASE_URL`, otherwise the
/// public routing and geocoding services directly.

final class BookingRepositoryProvider
    extends
        $FunctionalProvider<
          BookingRepository,
          BookingRepository,
          BookingRepository
        >
    with $Provider<BookingRepository> {
  /// The GauX API when the build sets `GAUX_API_BASE_URL`, otherwise the
  /// public routing and geocoding services directly.
  BookingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookingRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookingRepositoryHash();

  @$internal
  @override
  $ProviderElement<BookingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BookingRepository create(Ref ref) {
    return bookingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BookingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BookingRepository>(value),
    );
  }
}

String _$bookingRepositoryHash() => r'eed44f03ee6fbfb12d346b8f80a0395b317c0701';

/// Fares from the remote config's pricing, so prices change without a
/// release.

@ProviderFor(fareCalculator)
final fareCalculatorProvider = FareCalculatorProvider._();

/// Fares from the remote config's pricing, so prices change without a
/// release.

final class FareCalculatorProvider
    extends $FunctionalProvider<FareCalculator, FareCalculator, FareCalculator>
    with $Provider<FareCalculator> {
  /// Fares from the remote config's pricing, so prices change without a
  /// release.
  FareCalculatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fareCalculatorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fareCalculatorHash();

  @$internal
  @override
  $ProviderElement<FareCalculator> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FareCalculator create(Ref ref) {
    return fareCalculator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FareCalculator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FareCalculator>(value),
    );
  }
}

String _$fareCalculatorHash() => r'90b00d23733a95026aa4d2dcc068c97cd34ca0bf';

@ProviderFor(planRoute)
final planRouteProvider = PlanRouteProvider._();

final class PlanRouteProvider
    extends $FunctionalProvider<PlanRoute, PlanRoute, PlanRoute>
    with $Provider<PlanRoute> {
  PlanRouteProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'planRouteProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$planRouteHash();

  @$internal
  @override
  $ProviderElement<PlanRoute> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PlanRoute create(Ref ref) {
    return planRoute(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlanRoute value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlanRoute>(value),
    );
  }
}

String _$planRouteHash() => r'da0008a8c215a9c820b4a28bf4c429fbae3a0fe5';

@ProviderFor(searchPlaces)
final searchPlacesProvider = SearchPlacesProvider._();

final class SearchPlacesProvider
    extends $FunctionalProvider<SearchPlaces, SearchPlaces, SearchPlaces>
    with $Provider<SearchPlaces> {
  SearchPlacesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchPlacesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchPlacesHash();

  @$internal
  @override
  $ProviderElement<SearchPlaces> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SearchPlaces create(Ref ref) {
    return searchPlaces(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchPlaces value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchPlaces>(value),
    );
  }
}

String _$searchPlacesHash() => r'4a9a65a4dde2850700ce23bfd3cd2862e225bd48';
