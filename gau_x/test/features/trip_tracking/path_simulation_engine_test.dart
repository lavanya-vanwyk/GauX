import 'package:flutter_test/flutter_test.dart';
import 'package:gau_x/features/trip_tracking/data/datasources/simulated_route_datasource.dart';
import 'package:latlong2/latlong.dart';

void main() {
  group('PathSimulationEngine', () {
    final engine = PathSimulationEngine();

    // Roughly 220m of road heading north from Sandton station. Tests use a
    // very high speed so each run takes about 11 ticks (20m per 1ms tick).
    const path = [
      LatLng(-26.1075, 28.0567),
      LatLng(-26.1065, 28.0567),
      LatLng(-26.1055, 28.0567),
    ];

    test('emits nothing for an empty path', () async {
      final events = await engine.startDriverSimulation(
        path: const [],
        speedMetersPerSecond: 15,
        interval: Duration.zero,
      ).toList();

      expect(events, isEmpty);
    });

    test('starts at the first point and finishes at the last', () async {
      final events = await engine
          .startDriverSimulation(
            path: path,
            speedMetersPerSecond: 20000,
            interval: const Duration(milliseconds: 1),
          )
          .toList();

      expect(events.first.position, path.first);
      expect(events.first.totalDistanceCovered, 0);
      expect(events.last.position, path.last);
    });

    test('distance covered never decreases', () async {
      final events = await engine
          .startDriverSimulation(
            path: path,
            speedMetersPerSecond: 20000,
            interval: const Duration(milliseconds: 1),
          )
          .toList();

      for (var i = 1; i < events.length; i++) {
        expect(
          events[i].totalDistanceCovered,
          greaterThanOrEqualTo(events[i - 1].totalDistanceCovered),
        );
      }
    });

    test('heading points north for a northbound path', () async {
      final events = await engine
          .startDriverSimulation(
            path: path,
            speedMetersPerSecond: 20000,
            interval: const Duration(milliseconds: 1),
          )
          .toList();

      expect(events[1].heading, closeTo(0, 1));
    });
  });
}
