import 'package:latlong2/latlong.dart';

import '../../../../core/domain/failure.dart';
import '../../../../core/domain/result.dart';
import '../../../../core/utils/geo.dart';
import '../../domain/entities/driving_route.dart';
import '../../domain/entities/gautrain_station.dart';
import '../../domain/entities/place_suggestion.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/geocoding_remote_datasource.dart';
import '../datasources/mock_stations_datasource.dart';
import '../datasources/routing_remote_datasource.dart';

class BookingRepositoryImpl implements BookingRepository {
  const BookingRepositoryImpl({
    required RoutingRemoteDatasource routing,
    required GeocodingRemoteDatasource geocoding,
    required MockStationsDatasource stations,
  }) : _routing = routing,
       _geocoding = geocoding,
       _stations = stations;

  final RoutingRemoteDatasource _routing;
  final GeocodingRemoteDatasource _geocoding;
  final MockStationsDatasource _stations;

  @override
  GautrainStation get originStation => _stations.defaultStation;

  @override
  Future<Result<DrivingRoute>> getRoute(LatLng from, LatLng to) async {
    final result = await _routing.fetchRoute(from, to);
    switch (result) {
      case Err(:final failure):
        return Err(failure);
      case Success(value: final response) when response.routes.isEmpty:
        return Err(NotFoundFailure('No route from $from to $to'));
      case Success(value: final response):
        final points = response.routes.first.geometry.toLatLngs();
        // Measured from the geometry rather than OSRM's own `distance` so
        // fares match what riders were quoted before this refactor.
        return Success(
          DrivingRoute(
            points: points,
            distanceMeters: pathLengthMeters(points),
          ),
        );
    }
  }

  @override
  Future<Result<List<PlaceSuggestion>>> searchPlaces(
    String query, {
    int limit = 5,
  }) async {
    final result = await _geocoding.search(query, limit: limit);
    return switch (result) {
      Success(:final value) => Success(
        value.map((place) => place.toEntity()).toList(),
      ),
      Err(:final failure) => Err(failure),
    };
  }
}
