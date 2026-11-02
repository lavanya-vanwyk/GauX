import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gau_x/core/di/core_providers.dart';
import 'package:gau_x/core/domain/failure.dart';
import 'package:gau_x/core/domain/result.dart';
import 'package:gau_x/core/domain/ride_type.dart';
import 'package:gau_x/features/booking/data/datasources/mock_stations_datasource.dart';
import 'package:gau_x/features/booking/di/booking_providers.dart';
import 'package:gau_x/features/booking/domain/entities/driving_route.dart';
import 'package:gau_x/features/booking/presentation/state/booking_controller.dart';
import 'package:gau_x/features/booking/presentation/state/station_controller.dart';
import 'package:latlong2/latlong.dart';

import '../../helpers/fakes.dart';
import '../../helpers/test_overrides.dart';

void main() {
  final sandton = MockStationsDatasource.sandton.location;
  final nearby = LatLng(sandton.latitude + 0.01, sandton.longitude);
  final faraway = LatLng(sandton.latitude + 0.2, sandton.longitude);
  final route = DrivingRoute(points: [sandton, nearby], distanceMeters: 2500);

  late FakeBookingRepository repository;

  Future<ProviderContainer> createContainer() async {
    repository = FakeBookingRepository(routeResult: Success(route));
    final container = await testContainer(
      overrides: [
        bookingRepositoryProvider.overrideWithValue(repository),
        locationServiceProvider.overrideWithValue(
          FakeLocationService.unavailable(),
        ),
      ],
    );
    // Let the station lookup settle on the default (Sandton)
    await container.read(stationControllerProvider.future);
    return container;
  }

  BookingController controllerOf(ProviderContainer c) =>
      c.read(bookingControllerProvider.notifier);

  test('a destination in the service area gets a route and quote', () async {
    final container = await createContainer();

    final result = await controllerOf(container).setDestination(nearby);

    final state = container.read(bookingControllerProvider);
    expect(result, BookingResult.success);
    expect(state.destination, nearby);
    expect(state.routePoints, route.points);
    expect(state.quote?.fareCents, 4000); // R10 + 2.5 km × R12
    expect(state.isLoadingRoute, isFalse);
  });

  test('an out-of-area destination keeps the current booking', () async {
    final container = await createContainer();
    await controllerOf(container).setDestination(nearby);

    final result = await controllerOf(container).setDestination(faraway);

    expect(result, BookingResult.outsideGeofence);
    expect(container.read(bookingControllerProvider).destination, nearby);
    expect(container.read(bookingControllerProvider).quote, isNotNull);
  });

  test('a routing failure clears the booking', () async {
    final container = await createContainer();
    repository.routeResult = const Err(NetworkFailure('offline'));

    final result = await controllerOf(container).setDestination(nearby);

    expect(result, BookingResult.routeUnavailable);
    expect(container.read(bookingControllerProvider).destination, isNull);
  });

  test('switching ride type re-quotes the same route', () async {
    final container = await createContainer();
    await controllerOf(container).setDestination(nearby);

    controllerOf(container).setRideType(RideType.pool);

    expect(container.read(bookingControllerProvider).quote?.fareCents, 2500);
  });

  test('choosing another station clears the destination', () async {
    final container = await createContainer();
    await controllerOf(container).setDestination(nearby);

    container
        .read(stationControllerProvider.notifier)
        .select(MockStationsDatasource.stations.first);
    container.read(originStationProvider); // flush the change

    expect(container.read(bookingControllerProvider).destination, isNull);
  });
}
