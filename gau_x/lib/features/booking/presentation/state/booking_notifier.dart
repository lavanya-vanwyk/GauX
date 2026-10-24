import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/network/mock_directions_client.dart';

enum RideType { private, pool }

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
  
  // Default to private
  RideType _selectedRideType = RideType.private;

  LatLng get origin => _origin;
  LatLng? get destination => _destination;
  List<LatLng> get routePoints => _routePoints;
  bool get isLoadingRoute => _isLoadingRoute;
  double get distanceKm => _distanceKm;
  int get estimatedTimeMins => _estimatedTimeMins;
  double get fareAmount => _fareAmount;
  RideType get selectedRideType => _selectedRideType;

  Future<void> setDestination(LatLng newDestination) async {
    _destination = newDestination;
    _isLoadingRoute = true;
    notifyListeners();
    
    _routePoints = await _directionsClient.getRoute(_origin, newDestination);
    _calculateRideDetails();
    
    _isLoadingRoute = false;
    notifyListeners();
  }

  // Exposed to the UI to toggle the ride type
  void setRideType(RideType type) {
    _selectedRideType = type;
    _calculateRideDetails();
    notifyListeners();
  }

  void _calculateRideDetails() {
    if (_routePoints.isEmpty) return;
    
    double totalMeters = 0.0;
    for (int i = 0; i < _routePoints.length - 1; i++) {
      totalMeters += _distanceCalc.as(LengthUnit.Meter, _routePoints[i], _routePoints[i + 1]);
    }
    _distanceKm = totalMeters / 1000.0;
    _estimatedTimeMins = (totalMeters / 400).ceil();
    
    // Dynamic Pricing Logic
    if (_selectedRideType == RideType.pool) {
      _fareAmount = 25.0; 
    } else {
      _fareAmount = 10.0 + (_distanceKm * 12.0); 
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