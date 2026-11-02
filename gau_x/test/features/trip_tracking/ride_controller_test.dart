import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gau_x/core/domain/ride_type.dart';
import 'package:gau_x/features/booking/domain/policies/fare_calculator.dart';
import 'package:gau_x/features/trip_tracking/di/trip_tracking_providers.dart';
import 'package:gau_x/features/trip_tracking/domain/entities/driver_location.dart';
import 'package:gau_x/features/trip_tracking/presentation/state/ride_controller.dart';
import 'package:gau_x/features/trip_tracking/presentation/state/ride_state.dart';
import 'package:latlong2/latlong.dart';

import '../../helpers/fakes.dart';

void main() {
  const fares = FareCalculator();
  const route = [LatLng(-26.1075, 28.0567), LatLng(-26.0975, 28.0567)];
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

  ProviderContainer createContainer({
    List<DriverLocation> locations = const [halfway],
    bool holdOpen = false,
    double balance = 1000,
  }) {
    payments = RecordingPaymentPort(balance: balance);
    return ProviderContainer.test(
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
    final container = createContainer();
    final phases = recordPhases(container);

    final result = await container
        .read(rideControllerProvider.notifier)
        .startRide(privateQuote, route);
    await pumpEventQueue();

    expect(result, StartRideResult.started);
    expect(phases, [
      RidePhase.searching,
      RidePhase.arriving,
      RidePhase.inTransit,
      RidePhase.arrived,
    ]);
    expect(payments.charges.single, (
      amount: privateQuote.fare,
      description: 'GauX Private',
    ));
  });

  test('a pool ride matches commuters first', () async {
    final container = createContainer();
    final phases = recordPhases(container);

    await container
        .read(rideControllerProvider.notifier)
        .startRide(poolQuote, route);
    await pumpEventQueue();

    expect(phases.first, RidePhase.matching);
    expect(phases.last, RidePhase.arrived);
  });

  test('does not start without enough balance', () async {
    final container = createContainer(balance: 10);

    final result = await container
        .read(rideControllerProvider.notifier)
        .startRide(privateQuote, route);

    expect(result, StartRideResult.insufficientFunds);
    expect(container.read(rideControllerProvider), const RideState.idle());
  });

  test('cancelling in transit charges the partial fare', () async {
    final container = createContainer(holdOpen: true);
    final controller = container.read(rideControllerProvider.notifier);

    await controller.startRide(privateQuote, route);
    await pumpEventQueue();
    expect(container.read(rideControllerProvider).driver, halfway);

    final charged = await controller.cancelRide();

    expect(charged, 28.0); // R10 + 1.5 km × R12
    expect(payments.charges.single.description, 'Canceled: GauX Private');
    expect(container.read(rideControllerProvider), const RideState.idle());
  });

  test('cancelling before pickup is free', () async {
    final container = createContainer();
    final controller = container.read(rideControllerProvider.notifier);

    await controller.startRide(privateQuote, route);
    // Still searching: the zero-length delays haven't run yet
    expect(container.read(rideControllerProvider), isA<RideSearching>());
    expect(controller.cancellationFee, 0);

    await controller.cancelRide();
    await pumpEventQueue();

    expect(payments.charges, isEmpty);
    expect(container.read(rideControllerProvider), const RideState.idle());
  });

  test('a second ride cannot start while one is active', () async {
    final container = createContainer(holdOpen: true);
    final controller = container.read(rideControllerProvider.notifier);

    await controller.startRide(privateQuote, route);

    expect(
      await controller.startRide(privateQuote, route),
      StartRideResult.alreadyActive,
    );
  });
}
