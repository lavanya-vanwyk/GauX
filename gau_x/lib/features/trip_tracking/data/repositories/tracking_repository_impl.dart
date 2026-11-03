import 'package:latlong2/latlong.dart';

import '../../domain/entities/driver_location.dart';
import '../../domain/repositories/tracking_repository.dart';
import '../datasources/simulated_route_datasource.dart';

/// Drives a simulated vehicle along the route at city speed.
class SimulatedTrackingRepository implements TrackingRepository {
  const SimulatedTrackingRepository({
    PathSimulationEngine engine = const PathSimulationEngine(),
    this.speedMetersPerSecond = 15.0,
    this.interval = const Duration(milliseconds: 500),
  }) : _engine = engine;

  final PathSimulationEngine _engine;
  final double speedMetersPerSecond;
  final Duration interval;

  @override
  Stream<DriverLocation> trackDriver(List<LatLng> route) =>
      _engine.startDriverSimulation(
        path: route,
        speedMetersPerSecond: speedMetersPerSecond,
        interval: interval,
      );
}
