import 'dart:async';

import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/domain/ride_type.dart';
import '../../../booking/domain/entities/ride_quote.dart';
import '../../di/trip_tracking_providers.dart';
import '../../domain/entities/driver_location.dart';
import 'ride_state.dart';

part 'ride_controller.g.dart';

enum StartRideResult { started, insufficientFunds, alreadyActive }

/// How long each pre-pickup phase lasts in the simulation.
class RideTimings {
  const RideTimings({
    this.matching = const Duration(seconds: 3),
    this.searching = const Duration(seconds: 2),
    // Long enough for the rider to cancel before the ride starts
    this.arriving = const Duration(seconds: 5),
  });

  final Duration matching;
  final Duration searching;
  final Duration arriving;
}

@Riverpod(keepAlive: true)
RideTimings rideTimings(Ref ref) => const RideTimings();

/// Runs an active ride through its phases and charges the rider on arrival
/// or cancellation.
@Riverpod(keepAlive: true)
class RideController extends _$RideController {
  StreamSubscription<DriverLocation>? _tracking;

  // Bumped on every start and reset, so delayed steps from an old ride stop
  int _ride = 0;

  @override
  RideState build() {
    ref.onDispose(() => unawaited(_tracking?.cancel()));
    return const RideState.idle();
  }

  Future<StartRideResult> startRide(RideQuote quote, List<LatLng> route) async {
    if (!state.isIdle || route.isEmpty) return StartRideResult.alreadyActive;
    if (!await ref.read(tripPaymentPortProvider).canAfford(quote.fare)) {
      return StartRideResult.insufficientFunds;
    }
    if (!ref.mounted || !state.isIdle) return StartRideResult.alreadyActive;

    final ride = ++_ride;
    unawaited(_run(ride, quote, route, ref.read(rideTimingsProvider)));
    return StartRideResult.started;
  }

  Future<void> _run(
    int ride,
    RideQuote quote,
    List<LatLng> route,
    RideTimings timings,
  ) async {
    bool stillCurrent() => ref.mounted && ride == _ride;

    if (quote.rideType == RideType.pool) {
      state = RideState.matching(quote: quote, route: route);
      await Future<void>.delayed(timings.matching);
      if (!stillCurrent()) return;
    }

    state = RideState.searching(quote: quote, route: route);
    await Future<void>.delayed(timings.searching);
    if (!stillCurrent()) return;

    state = RideState.arriving(quote: quote, route: route);
    await Future<void>.delayed(timings.arriving);
    if (!stillCurrent()) return;

    state = RideState.inTransit(quote: quote, route: route);
    await _tracking?.cancel();
    _tracking = ref.read(trackingRepositoryProvider).trackDriver(route).listen((
      location,
    ) {
      if (state case final RideInTransit inTransit when stillCurrent()) {
        state = inTransit.copyWith(driver: location);
      }
    }, onDone: () => unawaited(_arrive(ride, quote)));
  }

  Future<void> _arrive(int ride, RideQuote quote) async {
    if (!ref.mounted || ride != _ride) return;
    await ref.read(completeTripProvider)(quote);
    if (ref.mounted && ride == _ride) state = RideState.arrived(quote: quote);
  }

  /// What cancelling right now would cost the rider.
  double get cancellationFee {
    final quote = state.activeQuote;
    if (quote == null || state is RideArrived) return 0;
    return ref
        .read(cancelTripProvider)
        .feeFor(
          quote,
          inTransit: state is RideInTransit,
          distanceCoveredMeters: state.driver?.totalDistanceCovered ?? 0,
        );
  }

  /// Cancels the ride and returns the amount charged: [fee] if given (the
  /// figure the rider confirmed), otherwise the current [cancellationFee].
  Future<double> cancelRide({double? fee}) async {
    final quote = state.activeQuote;
    if (quote == null || state is RideArrived) return 0;
    final charge = fee ?? cancellationFee;
    reset();
    return ref.read(cancelTripProvider)(quote, fee: charge);
  }

  /// Ends any ride without charging and returns to idle.
  void reset() {
    _ride++;
    unawaited(_tracking?.cancel());
    _tracking = null;
    state = const RideState.idle();
  }
}
