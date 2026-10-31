import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/domain/failure.dart';
import '../../../../core/domain/result.dart';
import '../../../../core/domain/ride_type.dart';
import '../../domain/entities/driving_route.dart';
import '../../domain/entities/place_suggestion.dart';
import '../../domain/entities/ride_quote.dart';
import '../../domain/policies/fare_calculator.dart';
import '../../domain/policies/geofence_policy.dart';
import '../../domain/repositories/booking_repository.dart';
import '../../domain/usecases/plan_route.dart';
import '../../domain/usecases/search_places.dart';

enum BookingResult { success, notFound, outsideGeofence, routeUnavailable }

/// Destination, route and quote for the ride being booked.
class BookingNotifier extends ChangeNotifier {
  BookingNotifier({
    required BookingRepository repository,
    required PlanRoute planRoute,
    required SearchPlaces searchPlaces,
    FareCalculator fares = const FareCalculator(),
  }) : _repository = repository,
       _planRoute = planRoute,
       _searchPlaces = searchPlaces,
       _fares = fares;

  final BookingRepository _repository;
  final PlanRoute _planRoute;
  final SearchPlaces _searchPlaces;
  final FareCalculator _fares;

  LatLng? _destination;
  DrivingRoute? _route;
  RideQuote? _quote;
  bool _isLoadingRoute = false;
  bool _isSearchingAddress = false;
  RideType _selectedRideType = RideType.private;

  LatLng get origin => _repository.originStation.location;
  LatLng? get destination => _destination;
  List<LatLng> get routePoints => _route?.points ?? const [];
  bool get isLoadingRoute => _isLoadingRoute;
  bool get isSearchingAddress => _isSearchingAddress;
  RideType get selectedRideType => _selectedRideType;

  /// The current quote, or null until a route is loaded.
  RideQuote? get quote => _quote;
  double get distanceKm => _quote?.distanceKm ?? 0;
  int get estimatedTimeMins => _quote?.etaMinutes ?? 0;
  double get fareAmount => _quote?.fare ?? 0;

  /// Autocomplete suggestions. Empty on any failure, so typing never shows
  /// an error; the rider can still submit the search.
  Future<List<PlaceSuggestion>> suggestPlaces(String query) async {
    final result = await _searchPlaces(query);
    if (result case Err(:final failure)) debugPrint('Autocomplete: $failure');
    return result.valueOrNull ?? const [];
  }

  /// Geocodes [address] and, if found, sets it as the destination.
  Future<BookingResult> searchAndSetDestination(String address) async {
    _isSearchingAddress = true;
    notifyListeners();

    final result = await _searchPlaces.bestMatch(address);

    _isSearchingAddress = false;
    switch (result) {
      case Success(:final value):
        return setDestination(value.location);
      case Err(failure: NotFoundFailure()):
        notifyListeners();
        return BookingResult.notFound;
      case Err(:final failure):
        debugPrint('Address search: $failure');
        notifyListeners();
        return BookingResult.routeUnavailable;
    }
  }

  Future<BookingResult> setDestination(LatLng newDestination) async {
    final previousDestination = _destination;
    _destination = newDestination;
    _isLoadingRoute = true;
    notifyListeners();

    final result = await _planRoute(newDestination);
    _isLoadingRoute = false;

    switch (result) {
      case Success(:final value):
        _route = value;
        _quote = _quoteFor(value);
        notifyListeners();
        return BookingResult.success;
      case Err(failure: OutsideServiceAreaFailure()):
        // Rejected destinations leave any existing booking in place.
        _destination = previousDestination;
        notifyListeners();
        return BookingResult.outsideGeofence;
      case Err(:final failure):
        debugPrint('Route planning: $failure');
        _clearRoute(keepRideType: true);
        notifyListeners();
        return BookingResult.routeUnavailable;
    }
  }

  void setRideType(RideType type) {
    _selectedRideType = type;
    if (_route case final route?) _quote = _quoteFor(route);
    notifyListeners();
  }

  void clearDestination() {
    _clearRoute(keepRideType: false);
    notifyListeners();
  }

  RideQuote _quoteFor(DrivingRoute route) => _fares.quote(
    rideType: _selectedRideType,
    distanceMeters: route.distanceMeters,
  );

  void _clearRoute({required bool keepRideType}) {
    _destination = null;
    _route = null;
    _quote = null;
    if (!keepRideType) _selectedRideType = RideType.private;
  }
}
