import 'dart:async';
import 'package:latlong2/latlong.dart';

import '../../../../core/utils/geo.dart';
import '../../domain/entities/driver_location.dart';

/// Moves a simulated driver along a path at a constant speed.
class PathSimulationEngine {
  const PathSimulationEngine();

  Stream<DriverLocation> startDriverSimulation({
    required List<LatLng> path,
    required double speedMetersPerSecond,
    required Duration interval,
  }) async* {
    if (path.isEmpty) return;

    const distanceCalc = Distance();
    double totalDistanceCovered = 0.0;
    double currentHeading = 0.0;
    LatLng previousPosition = path.first;

    final totalPathLength = pathLengthMeters(path);

    yield DriverLocation(
      position: path.first,
      totalDistanceCovered: 0.0,
      heading: 0.0,
    );

    final double secondsPerTick = interval.inMilliseconds / 1000.0;
    final double distancePerTick = speedMetersPerSecond * secondsPerTick;

    while (totalDistanceCovered < totalPathLength) {
      await Future<void>.delayed(interval);
      totalDistanceCovered += distancePerTick;

      if (totalDistanceCovered >= totalPathLength) {
        yield DriverLocation(
          position: path.last,
          totalDistanceCovered: totalPathLength,
          heading: currentHeading,
        );
        break;
      }

      LatLng currentPosition = path.last;
      double distanceAccumulator = 0.0;

      for (int i = 0; i < path.length - 1; i++) {
        final start = path[i];
        final end = path[i + 1];
        final segmentDist = distanceCalc
            .as(LengthUnit.Meter, start, end)
            .toDouble();

        if (totalDistanceCovered <= distanceAccumulator + segmentDist) {
          final double remainingInSegment =
              totalDistanceCovered - distanceAccumulator;
          final double t = segmentDist > 0
              ? (remainingInSegment / segmentDist)
              : 0.0;

          final double lat =
              start.latitude + (end.latitude - start.latitude) * t;
          final double lng =
              start.longitude + (end.longitude - start.longitude) * t;

          currentPosition = LatLng(lat, lng);
          break;
        }
        distanceAccumulator += segmentDist;
      }

      // Calculate bearing between previous and current point
      if (currentPosition != previousPosition) {
        currentHeading = distanceCalc.bearing(
          previousPosition,
          currentPosition,
        );
      }

      yield DriverLocation(
        position: currentPosition,
        totalDistanceCovered: totalDistanceCovered,
        heading: currentHeading,
      );

      previousPosition = currentPosition;
    }
  }
}
