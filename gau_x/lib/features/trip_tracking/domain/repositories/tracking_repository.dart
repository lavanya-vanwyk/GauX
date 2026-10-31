import 'package:latlong2/latlong.dart';

import '../entities/driver_location.dart';

/// Live driver telemetry for a trip. The simulator implements this today; a
/// vehicle WebSocket feed can replace it without touching the UI.
abstract interface class TrackingRepository {
  /// Emits driver positions along [route] and completes on arrival.
  Stream<DriverLocation> trackDriver(List<LatLng> route);
}
