import 'dart:async';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../../data/datasources/simulated_route_datasource.dart';
import '../../../booking/presentation/state/booking_notifier.dart';

enum RideState { initial, matching, searching, arriving, inTransit, arrived }

class SimulationController extends ChangeNotifier {
  final PathSimulationEngine _simulationEngine = PathSimulationEngine();
  StreamSubscription<DriverLocation>? _simulationSubscription;
  
  DriverLocation? _currentDriverLocation;
  RideState _rideState = RideState.initial;
  bool _isCancelled = false; // Added to kill async background timers

  DriverLocation? get currentDriverLocation => _currentDriverLocation;
  RideState get rideState => _rideState;
  
  bool get isSimulating => _rideState == RideState.inTransit || _rideState == RideState.arriving;

  Future<void> startSimulation(List<LatLng> route, RideType rideType) async {
    if (route.isEmpty) return;
    _isCancelled = false;

    if (rideType == RideType.pool) {
      _rideState = RideState.matching;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 3));
      if (_isCancelled) return; // Exit if cancelled during this phase
    }

    _rideState = RideState.searching;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    if (_isCancelled) return;

    _rideState = RideState.arriving;
    notifyListeners();
    // Extended to 5 seconds to give the user time to cancel before the ride starts
    await Future.delayed(const Duration(seconds: 5)); 
    if (_isCancelled) return;

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
        _rideState = RideState.arrived;
        notifyListeners();
      },
    );
  }

  void stopSimulation() {
    _isCancelled = true; 
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