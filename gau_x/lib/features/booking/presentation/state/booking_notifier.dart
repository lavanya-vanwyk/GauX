import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/network/mock_directions_client.dart';

class BookingNotifier extends ChangeNotifier {
  final MockDirectionsClient _directionsClient = MockDirectionsClient();

  final LatLng _origin = const LatLng(-26.1075, 28.0567);
  LatLng? _destination;
  List<LatLng> _routePoints = [];
  bool _isLoadingRoute = false;

  LatLng get origin => _origin;
  LatLng? get destination => _destination;
  List<LatLng> get routePoints => _routePoints;
  bool get isLoadingRoute => _isLoadingRoute;

  Future<void> setDestination(LatLng newDestination) async {
    _destination = newDestination;
    _isLoadingRoute = true;
    notifyListeners();

    _routePoints = await _directionsClient.getRoute(_origin, newDestination);
    _isLoadingRoute = false;
    notifyListeners();
  }

  void clearDestination() {
    _destination = null;
    _routePoints = [];
    notifyListeners();
  }
}