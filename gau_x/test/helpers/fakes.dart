import 'package:gau_x/core/domain/result.dart';
import 'package:gau_x/features/booking/data/datasources/mock_stations_datasource.dart';
import 'package:gau_x/features/booking/domain/entities/driving_route.dart';
import 'package:gau_x/features/booking/domain/entities/gautrain_station.dart';
import 'package:gau_x/features/booking/domain/entities/place_suggestion.dart';
import 'package:gau_x/features/booking/domain/repositories/booking_repository.dart';
import 'package:gau_x/features/trip_tracking/domain/ports/trip_payment_port.dart';
import 'package:latlong2/latlong.dart';

class FakeBookingRepository implements BookingRepository {
  FakeBookingRepository({
    this.routeResult = const Success(
      DrivingRoute(points: [], distanceMeters: 0),
    ),
    this.searchResult = const Success([]),
  });

  Result<DrivingRoute> routeResult;
  Result<List<PlaceSuggestion>> searchResult;

  final routeRequests = <(LatLng, LatLng)>[];
  final searchRequests = <(String, int)>[];

  @override
  GautrainStation get originStation => MockStationsDatasource.sandton;

  @override
  Future<Result<DrivingRoute>> getRoute(LatLng from, LatLng to) async {
    routeRequests.add((from, to));
    return routeResult;
  }

  @override
  Future<Result<List<PlaceSuggestion>>> searchPlaces(
    String query, {
    int limit = 5,
  }) async {
    searchRequests.add((query, limit));
    return searchResult;
  }
}

class RecordingPaymentPort implements TripPaymentPort {
  final charges = <({double amount, String description})>[];

  @override
  Future<void> charge({
    required double amount,
    required String description,
  }) async {
    charges.add((amount: amount, description: description));
  }
}
