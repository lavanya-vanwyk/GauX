import 'dart:async';
import 'package:latlong2/latlong.dart';

/// Represents the data layer output containing the current driver position.
class DriverLocation {
  final LatLng position;
  final double totalDistanceCovered;

  DriverLocation({required this.position, required this.totalDistanceCovered});
}

class PathSimulationEngine {
  /// Generates a live stream of coordinates by interpolating along the provided [path].
  /// 
  /// [speedMetersPerSecond] controls the virtual vehicle velocity.
  /// [interval] specifies how often updates are emitted (e.g., Duration(milliseconds: 500)).
  Stream<DriverLocation> startDriverSimulation({
    required List<LatLng> path,
    required double speedMetersPerSecond,
    required Duration interval,
  }) async* {
    if (path.isEmpty) return;

    final distanceCalc = const Distance();
    double totalDistanceCovered = 0.0;
    
    // Calculate the precise total path length to know when to terminate
    double totalPathLength = 0.0;
    for (int i = 0; i < path.length - 1; i++) {
      totalPathLength += distanceCalc.as(LengthUnit.Meter, path[i], path[i + 1]);
    }

    // Yield the initial starting position
    yield DriverLocation(position: path.first, totalDistanceCovered: 0.0);

    // Calculate structural distance increments per tick based on time duration fraction
    final double secondsPerTick = interval.inMilliseconds / 1000.0;
    final double distancePerTick = speedMetersPerSecond * secondsPerTick;

    while (totalDistanceCovered < totalPathLength) {
      await Future.delayed(interval);
      totalDistanceCovered += distancePerTick;

      if (totalDistanceCovered >= totalPathLength) {
        yield DriverLocation(position: path.last, totalDistanceCovered: totalPathLength);
        break;
      }

      // --- Inline Coordinate Interpolation Algorithm ---
      LatLng currentPosition = path.last;
      double distanceAccumulator = 0.0;

      for (int i = 0; i < path.length - 1; i++) {
        final start = path[i];
        final end = path[i + 1];
        final segmentDist = distanceCalc.as(LengthUnit.Meter, start, end).toDouble();

        if (totalDistanceCovered <= distanceAccumulator + segmentDist) {
          final double remainingInSegment = totalDistanceCovered - distanceAccumulator;
          final double t = segmentDist > 0 ? (remainingInSegment / segmentDist) : 0.0;

          final double lat = start.latitude + (end.latitude - start.latitude) * t;
          final double lng = start.longitude + (end.longitude - start.longitude) * t;
          
          currentPosition = LatLng(lat, lng);
          break;
        }
        distanceAccumulator += segmentDist;
      }

      yield DriverLocation(
        position: currentPosition,
        totalDistanceCovered: totalDistanceCovered,
      );
    }
  }
}
