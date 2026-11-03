import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gau_x/core/domain/result.dart';
import 'package:gau_x/core/domain/ride_type.dart';
import 'package:gau_x/features/booking/domain/entities/ride_quote.dart';
import 'package:gau_x/features/booking/domain/policies/fare_calculator.dart';
import 'package:gau_x/features/trip_tracking/di/trip_tracking_providers.dart';
import 'package:gau_x/features/trip_tracking/domain/entities/driver_location.dart';
import 'package:gau_x/features/trip_tracking/presentation/state/ride_controller.dart';
import 'package:gau_x/features/trip_tracking/presentation/state/ride_state.dart';
import 'package:latlong2/latlong.dart';

import '../../helpers/fakes.dart';
import '../../helpers/test_overrides.dart';

void main() {
  const fares = FareCalculator();
  const from = LatLng(-26.1075, 28.0567);
  const to = LatLng(-26.0975, 28.0567);
  const route = [from, to];
  final privateQuote = fares.quote(
    rideType: RideType.private,
    distanceMeters: 3000,
  );
  final poolQuote = fares.quote(rideType: RideType.pool, distanceMeters: 3000);
  const halfway = DriverLocation(
    position: LatLng(-26.1025, 28.0567),
    totalDistanceCovered: 1500,
  );

  late RecordingPaymentPort payments;

  Future<ProviderContainer> createContainer({
    List<DriverLocation> locations = const [halfway],
    bool holdOpen = false,
    int balanceCents = 100000,
  }) {
    payments = RecordingPaymentPort(balanceCents: balanceCents);
    return testContainer(
      overrides: [
        tripPaymentPortProvider.overrideWithValue(payments),
        trackingRepositoryProvider.overrideWithValue(
          FakeTrackingRepository(locations, holdOpen: holdOpen),
        ),
        rideTimingsProvider.overrideWithValue(
          const RideTimings(
            matching: Duration.zero,
            searching: Duration.zero,
            arriving: Duration.zero,
          ),
        ),
      ],
    );
  }

  Future<StartRideResult> start(ProviderContainer container, RideQuote quote) =>
      container
          .read(rideControllerProvider.notifier)
          .startRide(quote, route, from: from, to: to);

  /// Records each phase the ride passes through.
  List<RidePhase> recordPhases(ProviderContainer container) {
    final phases = <RidePhase>[];
    container.listen(
      rideControllerProvider.select((s) => s.phase),
      (_, phase) => phases.add(phase),
    );
    return phases;
  }

  test('a private ride runs to arrival and charges the fare', () async {
    final container = await createContainer();
    final phases = recordPhases(container);

    final result = await start(container, privateQuote);
    await pumpEventQueue();

    expect(result, StartRideResult.started);
    expect(phases, [
      RidePhase.searching,
      RidePhase.arriving,
      RidePhase.inTransit,
      RidePhase.arrived,
    ]);
    expect(payments.charges.single, (
      cents: privateQuote.fareCents,
      description: 'GauX Private',
    ));
  });

  test('rides run on the confirmed (server) quote', () async {
    final container = await createContainer();

    await start(container, privateQuote);

    expect(
      container.read(rideControllerProvider).activeQuote?.serverQuoteId,
      'quote-1',
    );
  });

  test('a pool ride matches commuters first', () async {
    final container = await createContainer();
    final phases = recordPhases(container);

    await start(container, poolQuote);
    await pumpEventQueue();

    expect(phases.first, RidePhase.matching);
    expect(phases.last, RidePhase.arrived);
  });

  test('does not start without enough balance', () async {
    final container = await createContainer(balanceCents: 1000);

    final result = await start(container, privateQuote);

    expect(result, StartRideResult.insufficientFunds);
    expect(container.read(rideControllerProvider), const RideState.idle());
  });

  test('an arrival charge that fails is reported, not lost', () async {
    final container = await createContainer();
    payments.failCharges = true;

    await start(container, privateQuote);
    await pumpEventQueue();

    final state = container.read(rideControllerProvider);
    expect(state, isA<RideArrived>());
    expect((state as RideArrived).paymentFailed, isTrue);
  });

  test('cancelling in transit charges the fee the rider saw', () async {
    final container = await createContainer(holdOpen: true);
    final controller = container.read(rideControllerProvider.notifier);

    await start(container, privateQuote);
    await pumpEventQueue();
    expect(container.read(rideControllerProvider).driver, halfway);

    final terms = controller.cancellationTerms!;
    final charged = await controller.cancelRide(terms);

    expect(terms.feeCents, 2800); // R10 + 1.5 km × R12
    expect(charged.valueOrNull, terms.feeCents);
    expect(payments.charges.single.description, 'Canceled: GauX Private');
    expect(container.read(rideControllerProvider), const RideState.idle());
  });

  test('cancelling before pickup is free', () async {
    final container = await createContainer();
    final controller = container.read(rideControllerProvider.notifier);

    await start(container, privateQuote);
    // Still searching: the zero-length delays haven't run yet
    expect(container.read(rideControllerProvider), isA<RideSearching>());
    final terms = controller.cancellationTerms!;
    expect(terms.feeCents, 0);

    final charged = await controller.cancelRide(terms);
    await pumpEventQueue();

    expect(charged, isA<Success<int>>());
    expect(payments.charges, isEmpty);
    expect(container.read(rideControllerProvider), const RideState.idle());
  });

  test('a second ride cannot start while one is active', () async {
    final container = await createContainer(holdOpen: true);

    await start(container, privateQuote);

    expect(await start(container, privateQuote), StartRideResult.alreadyActive);
  });
}
