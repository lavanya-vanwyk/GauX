import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/app_config.dart';
import '../../../core/di/core_providers.dart';
import '../data/datasources/geocoding_remote_datasource.dart';
import '../data/datasources/mock_stations_datasource.dart';
import '../data/datasources/routing_remote_datasource.dart';
import '../data/repositories/booking_repository_impl.dart';
import '../domain/policies/fare_calculator.dart';
import '../domain/repositories/booking_repository.dart';
import '../domain/usecases/plan_route.dart';
import '../domain/usecases/search_places.dart';

part 'booking_providers.g.dart';

@Riverpod(keepAlive: true)
BookingRepository bookingRepository(Ref ref) {
  final api = ref.watch(apiClientProvider);
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

@Riverpod(keepAlive: true)
FareCalculator fareCalculator(Ref ref) => const FareCalculator();

@Riverpod(keepAlive: true)
PlanRoute planRoute(Ref ref) =>
    PlanRoute(repository: ref.watch(bookingRepositoryProvider));

@Riverpod(keepAlive: true)
SearchPlaces searchPlaces(Ref ref) =>
    SearchPlaces(repository: ref.watch(bookingRepositoryProvider));
