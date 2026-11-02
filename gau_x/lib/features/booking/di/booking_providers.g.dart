// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bookingRepository)
final bookingRepositoryProvider = BookingRepositoryProvider._();

final class BookingRepositoryProvider
    extends
        $FunctionalProvider<
          BookingRepository,
          BookingRepository,
          BookingRepository
        >
    with $Provider<BookingRepository> {
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

String _$bookingRepositoryHash() => r'aa7e7252d00fc6ebbcc66e9dc962fad1b9d8a7df';

@ProviderFor(fareCalculator)
final fareCalculatorProvider = FareCalculatorProvider._();

final class FareCalculatorProvider
    extends $FunctionalProvider<FareCalculator, FareCalculator, FareCalculator>
    with $Provider<FareCalculator> {
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

String _$fareCalculatorHash() => r'8414f8eafd631883119f2a3d40a0f92b636884de';

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

String _$planRouteHash() => r'0a485de8e7f9e2ea361060d32ee7dad52df2a574';

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
