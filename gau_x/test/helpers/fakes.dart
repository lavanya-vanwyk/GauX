import 'package:gau_x/core/domain/failure.dart';
import 'package:gau_x/core/domain/result.dart';
import 'package:gau_x/core/location/location_service.dart';
import 'package:gau_x/features/booking/data/datasources/mock_stations_datasource.dart';
import 'package:gau_x/features/booking/domain/entities/driving_route.dart';
import 'package:gau_x/features/booking/domain/entities/gautrain_station.dart';
import 'package:gau_x/features/booking/domain/entities/place_suggestion.dart';
import 'package:gau_x/features/booking/domain/entities/ride_quote.dart';
import 'package:gau_x/features/booking/domain/policies/fare_calculator.dart';
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

/// Pays from an in-memory balance and records every charge.
class RecordingPaymentPort implements TripPaymentPort {
  RecordingPaymentPort({this.balanceCents = 1 << 40, this.failCharges = false});

  int balanceCents;

  /// Make every charge fail as if offline.
  bool failCharges;

  final charges = <({int cents, String description})>[];

  @override
  Future<Result<RideQuote>> confirmPrice(
    RideQuote quote, {
    required LatLng from,
    required LatLng to,
  }) async {
    if (balanceCents < quote.fareCents) {
      return const Err(InsufficientFundsFailure('short'));
    }
    return Success(quote.copyWith(serverQuoteId: 'quote-1'));
  }

  @override
  Future<Result<void>> chargeCompleted(RideQuote quote) async {
    if (failCharges) return const Err(NetworkFailure('offline'));
    _record(quote.fareCents, quote.rideType.displayName);
    return const Success(null);
  }

  @override
  Future<Result<int>> chargeCancelled(
    RideQuote quote, {
    required double distanceCoveredMeters,
  }) async {
    if (failCharges) return const Err(NetworkFailure('offline'));
    final fee = const FareCalculator().cancellationCents(
      quote,
      distanceCoveredMeters: distanceCoveredMeters,
    );
    if (fee > 0) _record(fee, 'Canceled: ${quote.rideType.displayName}');
    return Success(fee);
  }

  void _record(int cents, String description) {
    balanceCents -= cents;
    charges.add((cents: cents, description: description));
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
