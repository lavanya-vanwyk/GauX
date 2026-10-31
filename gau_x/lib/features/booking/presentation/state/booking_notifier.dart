import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/network/mock_directions_client.dart';
import '../../../../core/network/nominatim_client.dart'; // Import the new client

enum RideType { private, pool }

enum BookingResult { success, notFound, outsideGeofence }

class BookingNotifier extends ChangeNotifier {
  final MockDirectionsClient _directionsClient = MockDirectionsClient();
  final NominatimClient _geocodingClient =
      NominatimClient(); // Initialize client
  final Distance _distanceCalc = const Distance();

  final LatLng _origin = const LatLng(-26.1075, 28.0567);
  LatLng? _destination;
  List<LatLng> _routePoints = [];
  bool _isLoadingRoute = false;
  bool _isSearchingAddress = false; // New state for search loading

  double _distanceKm = 0.0;
  int _estimatedTimeMins = 0;
  double _fareAmount = 0.0;
  RideType _selectedRideType = RideType.private;

  // Getters
  LatLng get origin => _origin;
  LatLng? get destination => _destination;
  List<LatLng> get routePoints => _routePoints;
  bool get isLoadingRoute => _isLoadingRoute;
  bool get isSearchingAddress => _isSearchingAddress; // Expose to UI
  double get distanceKm => _distanceKm;
  int get estimatedTimeMins => _estimatedTimeMins;
  double get fareAmount => _fareAmount;
  RideType get selectedRideType => _selectedRideType;

  // New method to handle text-based address searches
  Future<BookingResult> searchAndSetDestination(String address) async {
    _isSearchingAddress = true;
    notifyListeners();

    final coordinates =
        await _geocodingClient.getCoordinatesFromAddress(address);

    _isSearchingAddress = false;
    if (coordinates != null) {
      return setDestination(coordinates);
    } else {
      notifyListeners();
      return BookingResult.notFound;
    }
  }

  Future<BookingResult> setDestination(LatLng newDestination) async {
    // 2. Implement the 5km Geo-Fence Clamp
    final double straightLineDistanceMeters = _distanceCalc
        .as(
          LengthUnit.Meter,
          _origin,
          newDestination,
        )
        .toDouble();

    if (straightLineDistanceMeters > 5000) {
      return BookingResult.outsideGeofence;
    }

    _destination = newDestination;
    _isLoadingRoute = true;
    notifyListeners();

    _routePoints = await _directionsClient.getRoute(_origin, newDestination);
    _calculateRideDetails();

    _isLoadingRoute = false;
    notifyListeners();
    return BookingResult.success;
  }

  void setRideType(RideType type) {
    _selectedRideType = type;
    _calculateRideDetails();
    notifyListeners();
  }

  void _calculateRideDetails() {
    if (_routePoints.isEmpty) return;

    double totalMeters = 0.0;
    for (int i = 0; i < _routePoints.length - 1; i++) {
      totalMeters += _distanceCalc.as(
          LengthUnit.Meter, _routePoints[i], _routePoints[i + 1]);
    }
    _distanceKm = totalMeters / 1000.0;
    _estimatedTimeMins = (totalMeters / 400).ceil();

    if (_selectedRideType == RideType.pool) {
      _fareAmount = 25.0;
    } else {
      _fareAmount = 10.0 + (_distanceKm * 12.0);
    }
  }

  // Calculates partial fare if the ride is canceled in-transit
  double calculatePartialFare(double distanceCoveredMeters) {
    final double coveredKm = distanceCoveredMeters / 1000.0;

    if (_selectedRideType == RideType.pool) {
      // For a flat rate Pool, charge a ratio of the distance covered
      final double ratio = _distanceKm > 0 ? (coveredKm / _distanceKm) : 0.0;
      return double.parse((25.0 * ratio).toStringAsFixed(2));
    } else {
      // For Private, charge the base fare (R10) plus the km covered
      return double.parse((10.0 + (coveredKm * 12.0)).toStringAsFixed(2));
    }
  }

  void clearDestination() {
    _destination = null;
    _routePoints = [];
    _distanceKm = 0.0;
    _estimatedTimeMins = 0;
    _fareAmount = 0.0;
    _selectedRideType = RideType.private;
    notifyListeners();
  }
}
