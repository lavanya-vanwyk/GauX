import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/app_config.dart';
import '../../../core/di/core_providers.dart';
import '../../../core/remote_config/remote_config_providers.dart';
import '../data/datasources/gaux_api_datasource.dart';
import '../data/datasources/geocoding_remote_datasource.dart';
import '../data/datasources/mock_stations_datasource.dart';
import '../data/datasources/routing_remote_datasource.dart';
import '../data/repositories/booking_repository_impl.dart';
import '../data/repositories/gaux_api_booking_repository.dart';
import '../domain/policies/fare_calculator.dart';
import '../domain/policies/geofence_policy.dart';
import '../domain/repositories/booking_repository.dart';
import '../domain/usecases/plan_route.dart';
import '../domain/usecases/search_places.dart';

part 'booking_providers.g.dart';

/// The GauX API when the build sets `GAUX_API_BASE_URL`, otherwise the
/// public routing and geocoding services directly.
@Riverpod(keepAlive: true)
BookingRepository bookingRepository(Ref ref) {
  final api = ref.watch(apiClientProvider);
  if (AppConfig.usesGauxApi) {
    return GauxApiBookingRepository(
      api: GauxApiDatasource(client: api, baseUrl: AppConfig.gauxApiBaseUrl),
    );
  }
  return BookingRepositoryImpl(
    routing: RoutingRemoteDatasource(
      client: api,
      baseUrl: AppConfig.osrmBaseUrl,
    ),
    geocoding: GeocodingRemoteDatasource(
      client: api,
      baseUrl: AppConfig.nominatimBaseUrl,
    ),
    stations: const MockStationsDatasource(),
  );
}

/// Fares from the remote config's pricing, so prices change without a
/// release.
@Riverpod(keepAlive: true)
FareCalculator fareCalculator(Ref ref) {
  final pricing = ref.watch(
    remoteConfigControllerProvider.select((c) => c.pricing),
  );
  return FareCalculator(
    privateBaseFare: pricing.privateBaseFare,
    privatePerKm: pricing.privatePerKm,
    poolFlatFare: pricing.poolFlatFare,
    averageMetersPerMinute: pricing.averageMetersPerMinute,
  );
}

@Riverpod(keepAlive: true)
PlanRoute planRoute(Ref ref) {
  final radius = ref.watch(
    remoteConfigControllerProvider.select((c) => c.serviceArea.radiusMeters),
  );
  return PlanRoute(
    repository: ref.watch(bookingRepositoryProvider),
    geofence: GeofencePolicy(radiusMeters: radius),
  );
}

@Riverpod(keepAlive: true)
SearchPlaces searchPlaces(Ref ref) =>
    SearchPlaces(repository: ref.watch(bookingRepositoryProvider));
