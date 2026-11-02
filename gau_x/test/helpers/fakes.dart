import 'package:gau_x/core/domain/result.dart';
import 'package:gau_x/core/location/location_service.dart';
import 'package:gau_x/features/booking/data/datasources/mock_stations_datasource.dart';
import 'package:gau_x/features/booking/domain/entities/driving_route.dart';
import 'package:gau_x/features/booking/domain/entities/gautrain_station.dart';
import 'package:gau_x/features/booking/domain/entities/place_suggestion.dart';
import 'package:gau_x/features/booking/domain/repositories/booking_repository.dart';
import 'package:gau_x/features/trip_tracking/domain/entities/driver_location.dart';
import 'package:gau_x/features/trip_tracking/domain/ports/trip_payment_port.dart';
import 'package:gau_x/features/trip_tracking/domain/repositories/tracking_repository.dart';
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
  Future<Result<List<GautrainStation>>> getStations() async =>
      const Success(MockStationsDatasource.stations);

  @override
  GautrainStation get defaultStation => MockStationsDatasource.sandton;

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
  RecordingPaymentPort({this.balance = double.infinity});

  double balance;
  final charges = <({double amount, String description})>[];

  @override
  Future<bool> canAfford(double amount) async => balance >= amount;

  @override
  Future<void> charge({
    required double amount,
    required String description,
  }) async {
    balance -= amount;
    charges.add((amount: amount, description: description));
  }
}

class FakeLocationService implements LocationService {
  FakeLocationService(this.result);

  /// Rider is standing at [position].
  FakeLocationService.at(LatLng position) : result = Success(position);

  /// Location permission denied.
  FakeLocationService.unavailable()
    : result = const Err(LocationUnavailableFailure('denied'));

  final Result<LatLng> result;

  @override
  Future<Result<LatLng>> currentPosition() async => result;
}

/// Emits [locations] immediately, then completes (the driver arrives).
class FakeTrackingRepository implements TrackingRepository {
  FakeTrackingRepository(this.locations, {this.holdOpen = false});

  final List<DriverLocation> locations;

  /// When true the stream never completes, so the ride stays in transit.
  final bool holdOpen;

  @override
  Stream<DriverLocation> trackDriver(List<LatLng> route) async* {
    yield* Stream.fromIterable(locations);
    if (holdOpen) await Future<void>.delayed(const Duration(days: 1));
  }
}
