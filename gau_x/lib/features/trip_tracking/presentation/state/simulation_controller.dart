import 'dart:async';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../../data/datasources/simulated_route_datasource.dart';

class SimulationController extends ChangeNotifier {
  final PathSimulationEngine _simulationEngine = PathSimulationEngine();
  StreamSubscription<DriverLocation>? _simulationSubscription;

  DriverLocation? _currentDriverLocation;
  bool _isSimulating = false;

  DriverLocation? get currentDriverLocation => _currentDriverLocation;
  bool get isSimulating => _isSimulating;

  void startSimulation(List<LatLng> route) {
    if (route.isEmpty) return;

    _isSimulating = true;
    notifyListeners();

    _simulationSubscription?.cancel();

    // Start simulation at ~15 meters per second (approx 54 km/h) updating every 500ms
    final stream = _simulationEngine.startDriverSimulation(
      path: route,
      speedMetersPerSecond: 15.0,
      interval: const Duration(milliseconds: 500),
    );

    _simulationSubscription = stream.listen(
          (location) {
        _currentDriverLocation = location;
        notifyListeners();
      },
      onDone: () {
        _isSimulating = false;
        notifyListeners();
      },
    );
  }

  void stopSimulation() {
    _simulationSubscription?.cancel();
    _isSimulating = false;
    _currentDriverLocation = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _simulationSubscription?.cancel();
    super.dispose();
  }
}