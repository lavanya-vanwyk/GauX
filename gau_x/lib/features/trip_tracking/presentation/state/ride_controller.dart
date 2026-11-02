import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/domain/result.dart';
import '../../../../core/domain/ride_type.dart';
import '../../../booking/domain/entities/ride_quote.dart';
import '../../di/trip_tracking_providers.dart';
import '../../domain/entities/driver_location.dart';
import '../../domain/ports/trip_payment_port.dart';
import 'ride_state.dart';

part 'ride_controller.g.dart';

enum StartRideResult {
  started,
  insufficientFunds,

  /// The price couldn't be confirmed (e.g. the API is unreachable).
  priceUnavailable,
  alreadyActive,
}

/// What cancelling would cost at a given moment. Captured when the rider
/// opens the cancel dialog, so they're charged the figure they agreed to.
typedef CancellationTerms = ({
  bool inTransit,
  double distanceCoveredMeters,
  int feeCents,
});

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

  /// Confirms the price for the ride from [from] to [to] and starts it.
  Future<StartRideResult> startRide(
    RideQuote quote,
    List<LatLng> route, {
    required LatLng from,
    required LatLng to,
  }) async {
    if (!state.isIdle || route.isEmpty) return StartRideResult.alreadyActive;
    final confirmed = await ref
        .read(tripPaymentPortProvider)
        .confirmPrice(quote, from: from, to: to);
    if (!ref.mounted || !state.isIdle) return StartRideResult.alreadyActive;

    switch (confirmed) {
      case Err(failure: InsufficientFundsFailure()):
        return StartRideResult.insufficientFunds;
      case Err(:final failure):
        debugPrint('Ride: price not confirmed ($failure)');
        return StartRideResult.priceUnavailable;
      case Success(value: final confirmedQuote):
        final ride = ++_ride;
        unawaited(
          _run(ride, confirmedQuote, route, ref.read(rideTimingsProvider)),
        );
        return StartRideResult.started;
    }
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
    final paid = await ref.read(completeTripProvider)(quote);
    if (paid case Err(:final failure)) {
      debugPrint('Ride: arrival charge failed ($failure)');
    }
    if (ref.mounted && ride == _ride) {
      state = RideState.arrived(quote: quote, paymentFailed: paid is Err);
    }
  }

  /// What cancelling right now would cost, or null with no ride to cancel.
  CancellationTerms? get cancellationTerms {
    final quote = state.activeQuote;
    if (quote == null || state is RideArrived) return null;
    final inTransit = state is RideInTransit;
    final distance = state.driver?.totalDistanceCovered ?? 0;
    return (
      inTransit: inTransit,
      distanceCoveredMeters: distance,
      feeCents: ref
          .read(cancelTripProvider)
          .feeFor(quote, inTransit: inTransit, distanceCoveredMeters: distance),
    );
  }

  /// Cancels the ride on [terms] (from [cancellationTerms], as shown to the
  /// rider) and returns the cents actually charged.
  Future<Result<int>> cancelRide(CancellationTerms terms) async {
    final quote = state.activeQuote;
    if (quote == null || state is RideArrived) return const Success(0);
    reset();
    return ref.read(cancelTripProvider)(
      quote,
      inTransit: terms.inTransit,
      distanceCoveredMeters: terms.distanceCoveredMeters,
    );
  }

  /// Ends any ride without charging and returns to idle.
  void reset() {
    _ride++;
    unawaited(_tracking?.cancel());
    _tracking = null;
    state = const RideState.idle();
  }
}
