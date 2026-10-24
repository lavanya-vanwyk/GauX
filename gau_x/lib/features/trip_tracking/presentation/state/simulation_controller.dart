import 'dart:async';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../../data/datasources/simulated_route_datasource.dart';
import '../../../booking/presentation/state/booking_notifier.dart';

// Added 'matching' to the sequence
enum RideState { initial, matching, searching, arriving, inTransit, arrived }

class SimulationController extends ChangeNotifier {
  final PathSimulationEngine _simulationEngine = PathSimulationEngine();
  StreamSubscription<DriverLocation>? _simulationSubscription;
  
  DriverLocation? _currentDriverLocation;
  RideState _rideState = RideState.initial;

  DriverLocation? get currentDriverLocation => _currentDriverLocation;
  RideState get rideState => _rideState;
  
  bool get isSimulating => _rideState == RideState.inTransit || _rideState == RideState.arriving;

  // Updated to accept RideType for conditional flow
  Future<void> startSimulation(List<LatLng> route, RideType rideType) async {
    if (route.isEmpty) return;

    // 1. Optional Matching Phase (Pool only)
    if (rideType == RideType.pool) {
      _rideState = RideState.matching;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 3));
    }

    // 2. Searching for driver
    _rideState = RideState.searching;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));

    // 3. Driver Arriving (Mocking a brief pause before movement)
    _rideState = RideState.arriving;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));

    // 4. In Transit (Car starts moving)
    _rideState = RideState.inTransit;
    notifyListeners();

    _simulationSubscription?.cancel();
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
        // 5. Arrived
        _rideState = RideState.arrived;
        notifyListeners();
      },
    );
  }

  void stopSimulation() {
    _simulationSubscription?.cancel();
    _rideState = RideState.initial;
    _currentDriverLocation = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _simulationSubscription?.cancel();
    super.dispose();
  }
}