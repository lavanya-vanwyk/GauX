import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/domain/ride_type.dart';
import '../../../booking/domain/entities/ride_quote.dart';
import '../../domain/entities/driver_location.dart';
import '../../domain/repositories/tracking_repository.dart';
import '../../domain/usecases/cancel_trip.dart';
import '../../domain/usecases/complete_trip.dart';

enum RideState { initial, matching, searching, arriving, inTransit, arrived }

/// Runs an active ride: driver matching, the drive itself, and charging the
/// rider on arrival or cancellation.
class SimulationController extends ChangeNotifier {
  SimulationController({
    required TrackingRepository tracking,
    required CompleteTrip completeTrip,
    required CancelTrip cancelTrip,
  }) : _tracking = tracking,
       _completeTrip = completeTrip,
       _cancelTrip = cancelTrip;

  final TrackingRepository _tracking;
  final CompleteTrip _completeTrip;
  final CancelTrip _cancelTrip;

  StreamSubscription<DriverLocation>? _simulationSubscription;
  DriverLocation? _currentDriverLocation;
  RideQuote? _activeQuote;
  RideState _rideState = RideState.initial;
  bool _isCancelled = false; // Stops the matching delays after a cancel

  DriverLocation? get currentDriverLocation => _currentDriverLocation;
  RideState get rideState => _rideState;

  /// The quote for the ride in progress, if any.
  RideQuote? get activeQuote => _activeQuote;

  bool get isSimulating =>
      _rideState == RideState.inTransit || _rideState == RideState.arriving;

  /// What cancelling right now would cost the rider.
  double get cancellationFee {
    final quote = _activeQuote;
    if (quote == null) return 0;
    return _cancelTrip.feeFor(
      quote,
      inTransit: _rideState == RideState.inTransit,
      distanceCoveredMeters: _currentDriverLocation?.totalDistanceCovered ?? 0,
    );
  }

  Future<void> startRide(RideQuote quote, List<LatLng> route) async {
    if (route.isEmpty) return;
    _isCancelled = false;
    _activeQuote = quote;

    if (quote.rideType == RideType.pool) {
      _rideState = RideState.matching;
      notifyListeners();
      await Future<void>.delayed(const Duration(seconds: 3));
      if (_isCancelled) return;
    }

    _rideState = RideState.searching;
    notifyListeners();
    await Future<void>.delayed(const Duration(seconds: 2));
    if (_isCancelled) return;

    _rideState = RideState.arriving;
    notifyListeners();
    // Long enough for the rider to cancel before the ride starts
    await Future<void>.delayed(const Duration(seconds: 5));
    if (_isCancelled) return;

    _rideState = RideState.inTransit;
    notifyListeners();

    await _simulationSubscription?.cancel();
    _simulationSubscription = _tracking.trackDriver(route).listen((location) {
      _currentDriverLocation = location;
      notifyListeners();
    }, onDone: () => unawaited(_arrive(quote)));
  }

  Future<void> _arrive(RideQuote quote) async {
    await _completeTrip(quote);
    if (_isCancelled) return;
    _rideState = RideState.arrived;
    notifyListeners();
  }

  /// Cancels the ride and returns the amount charged: [fee] if given (the
  /// figure the rider confirmed), otherwise the current [cancellationFee].
  Future<double> cancelRide({double? fee}) async {
    final quote = _activeQuote;
    final charge = fee ?? cancellationFee;
    stopSimulation();
    if (quote == null) return 0;
    return _cancelTrip(quote, fee: charge);
  }

  /// Ends the ride without charging and returns to the initial state.
  void stopSimulation() {
    _isCancelled = true;
    unawaited(_simulationSubscription?.cancel());
    _simulationSubscription = null;
    _rideState = RideState.initial;
    _currentDriverLocation = null;
    _activeQuote = null;
    notifyListeners();
  }

  @override
  void dispose() {
    unawaited(_simulationSubscription?.cancel());
    super.dispose();
  }
}
