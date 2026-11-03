import 'package:flutter/foundation.dart';
import 'package:gaux_contracts/gaux_contracts.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/domain/failure.dart';
import '../../../../core/domain/result.dart';
import '../../domain/entities/driving_route.dart';
import '../../domain/entities/gautrain_station.dart';
import '../../domain/entities/place_suggestion.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/gaux_api_datasource.dart';
import '../datasources/mock_stations_datasource.dart';

/// Booking data from the GauX API, which proxies and caches the routing and
/// geocoding providers. Falls back to the bundled stations if the API can't
/// be reached.
class GauxApiBookingRepository implements BookingRepository {
  const GauxApiBookingRepository({
    required GauxApiDatasource api,
    MockStationsDatasource bundledStations = const MockStationsDatasource(),
  }) : _api = api,
       _bundled = bundledStations;

  final GauxApiDatasource _api;
  final MockStationsDatasource _bundled;

  @override
  GautrainStation get defaultStation => _bundled.defaultStation;

  @override
  Future<Result<List<GautrainStation>>> getStations() async {
    switch (await _api.fetchStations()) {
      case Success(:final value) when value.stations.isNotEmpty:
        return Success([
          for (final s in value.stations)
            GautrainStation(
              id: s.id,
              name: s.name,
              location: _latLng(s.location),
            ),
        ]);
      case Success():
        return const Success(MockStationsDatasource.stations);
      case Err(:final failure):
        debugPrint('Stations: using bundled list ($failure)');
        return const Success(MockStationsDatasource.stations);
    }
  }

  @override
  Future<Result<DrivingRoute>> getRoute(LatLng from, LatLng to) async {
    return switch (await _api.fetchRoute(from, to)) {
      Success(:final value) => Success(
        DrivingRoute(
          points: value.points.map(_latLng).toList(),
          distanceMeters: value.distanceMeters,
        ),
      ),
      Err(failure: ServerFailure(statusCode: 404)) => Err(
        NotFoundFailure('No route from $from to $to'),
      ),
      Err(:final failure) => Err(failure),
    };
  }

  @override
  Future<Result<List<PlaceSuggestion>>> searchPlaces(
    String query, {
    int limit = 5,
  }) async {
    return switch (await _api.searchPlaces(query, limit: limit)) {
      Success(:final value) => Success([
        for (final place in value.places)
          PlaceSuggestion(name: place.name, location: _latLng(place.location)),
      ]),
      Err(:final failure) => Err(failure),
    };
  }

  static LatLng _latLng(GeoPoint p) => LatLng(p.lat, p.lng);
}
