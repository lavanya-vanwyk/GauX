import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/network/mock_directions_client.dart';

class BookingNotifier extends ChangeNotifier {
  final MockDirectionsClient _directionsClient = MockDirectionsClient();
  final Distance _distanceCalc = const Distance();

  final LatLng _origin = const LatLng(-26.1075, 28.0567);
  LatLng? _destination;
  List<LatLng> _routePoints = [];
  bool _isLoadingRoute = false;

  double _distanceKm = 0.0;
  int _estimatedTimeMins = 0;
  double _fareAmount = 0.0;

  LatLng get origin => _origin;
  LatLng? get destination => _destination;
  List<LatLng> get routePoints => _routePoints;
  bool get isLoadingRoute => _isLoadingRoute;
  double get distanceKm => _distanceKm;
  int get estimatedTimeMins => _estimatedTimeMins;
  double get fareAmount => _fareAmount;

  Future<void> setDestination(LatLng newDestination) async {
    _destination = newDestination;
    _isLoadingRoute = true;
    notifyListeners();

    _routePoints = await _directionsClient.getRoute(_origin, newDestination);
    _calculateRideDetails();

    _isLoadingRoute = false;
    notifyListeners();
  }

  void _calculateRideDetails() {
    if (_routePoints.isEmpty) return;

    double totalMeters = 0.0;
    for (int i = 0; i < _routePoints.length - 1; i++) {
      totalMeters += _distanceCalc.as(LengthUnit.Meter, _routePoints[i], _routePoints[i + 1]);
    }

    _distanceKm = totalMeters / 1000.0;
    _estimatedTimeMins = (totalMeters / 400).ceil(); // Mocking vehicle speed at ~400m per minute
    _fareAmount = 15.0 + (_distanceKm * 12.0); // Base fare R15 + R12 per km
  }

  void clearDestination() {
    _destination = null;
    _routePoints = [];
    _distanceKm = 0.0;
    _estimatedTimeMins = 0;
    _fareAmount = 0.0;
    notifyListeners();
  }
}