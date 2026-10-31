import 'package:latlong2/latlong.dart';

import '../../../../core/domain/failure.dart';
import '../../../../core/utils/geo.dart';

/// GauX only serves destinations within a fixed radius of the station, so
/// vehicles stay close and pickups stay fast.
class GeofencePolicy {
  const GeofencePolicy({this.radiusMeters = 5000});

  final double radiusMeters;

  bool allows({required LatLng station, required LatLng destination}) =>
      straightLineMeters(station, destination) <= radiusMeters;
}

/// The destination is outside the station's service radius.
final class OutsideServiceAreaFailure extends Failure {
  const OutsideServiceAreaFailure(super.message);
}
