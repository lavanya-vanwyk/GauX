import 'package:latlong2/latlong.dart';

import '../../../../core/domain/result.dart';
import '../entities/driving_route.dart';
import '../policies/geofence_policy.dart';
import '../repositories/booking_repository.dart';

/// Checks a destination against the service area, then fetches the route
/// from the origin station.
class PlanRoute {
  const PlanRoute({
    required BookingRepository repository,
    GeofencePolicy geofence = const GeofencePolicy(),
  }) : _repository = repository,
       _geofence = geofence;

  final BookingRepository _repository;
  final GeofencePolicy _geofence;

  Future<Result<DrivingRoute>> call(LatLng destination) async {
    final station = _repository.originStation;
    if (!_geofence.allows(
      station: station.location,
      destination: destination,
    )) {
      return Err(
        OutsideServiceAreaFailure(
          '$destination is more than ${_geofence.radiusMeters}m from '
          '${station.name}',
        ),
      );
    }
    return _repository.getRoute(station.location, destination);
  }
}
