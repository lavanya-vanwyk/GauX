import 'package:flutter_test/flutter_test.dart';
import 'package:gau_x/core/domain/failure.dart';
import 'package:gau_x/core/domain/result.dart';
import 'package:gau_x/features/booking/data/datasources/mock_stations_datasource.dart';
import 'package:gau_x/features/booking/domain/policies/geofence_policy.dart';
import 'package:gau_x/features/booking/domain/usecases/plan_route.dart';
import 'package:latlong2/latlong.dart';

import '../../helpers/fakes.dart';

void main() {
  final station = MockStationsDatasource.sandton.location;
  // 0.01° of latitude is about 1.1 km.
  final inside = LatLng(station.latitude + 0.04, station.longitude);
  final outside = LatLng(station.latitude + 0.05, station.longitude);

  group('GeofencePolicy', () {
    const geofence = GeofencePolicy();

    test('allows destinations within 5 km', () {
      expect(geofence.allows(station: station, destination: inside), isTrue);
    });

    test('rejects destinations beyond 5 km', () {
      expect(geofence.allows(station: station, destination: outside), isFalse);
    });
  });

  group('PlanRoute', () {
    test('measures the service area from the chosen origin', () async {
      final repository = FakeBookingRepository();
      const pretoria = LatLng(-25.7586, 28.1895);

      final result = await PlanRoute(repository: repository)(
        origin: MockStationsDatasource.stations.firstWhere(
          (s) => s.id == 'pretoria',
        ),
        destination: pretoria,
      );

      expect(result, isA<Success<Object?>>());
      expect(repository.routeRequests.single.$2, pretoria);
    });

    test('rejects out-of-area destinations without calling routing', () async {
      final repository = FakeBookingRepository();

      final result = await PlanRoute(repository: repository)(
        origin: MockStationsDatasource.sandton,
        destination: outside,
      );

      expect(
        result,
        isA<Err<Object?>>().having(
          (e) => e.failure,
          'failure',
          isA<OutsideServiceAreaFailure>(),
        ),
      );
      expect(repository.routeRequests, isEmpty);
    });

    test('routes from the origin station', () async {
      final repository = FakeBookingRepository();

      final result = await PlanRoute(repository: repository)(
        origin: MockStationsDatasource.sandton,
        destination: inside,
      );

      expect(result, isA<Success<Object?>>());
      expect(repository.routeRequests.single, (station, inside));
    });

    test('passes routing failures through', () async {
      final repository = FakeBookingRepository(
        routeResult: const Err(NetworkFailure('offline')),
      );

      final result = await PlanRoute(repository: repository)(
        origin: MockStationsDatasource.sandton,
        destination: inside,
      );

      expect((result as Err).failure, isA<NetworkFailure>());
    });
  });
}
