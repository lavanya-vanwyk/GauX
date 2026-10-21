import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class BookingNotifier extends ChangeNotifier {
  // Hardcoded origin: Sandton Gautrain Station
  final LatLng _origin = const LatLng(-26.1075, 28.0567);

  LatLng? _destination;

  LatLng get origin => _origin;
  LatLng? get destination => _destination;

  void setDestination(LatLng newDestination) {
    _destination = newDestination;
    notifyListeners();
  }

  void clearDestination() {
    _destination = null;
    notifyListeners();
  }
}