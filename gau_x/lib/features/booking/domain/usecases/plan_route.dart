import 'package:latlong2/latlong.dart';

import '../../../../core/domain/result.dart';
import '../entities/driving_route.dart';
import '../entities/gautrain_station.dart';
import '../policies/geofence_policy.dart';
import '../repositories/booking_repository.dart';

/// Checks a destination against the service area around [origin], then
/// fetches the route.
class PlanRoute {
  const PlanRoute({
    required BookingRepository repository,
    GeofencePolicy geofence = const GeofencePolicy(),
  }) : _repository = repository,
       _geofence = geofence;

  final BookingRepository _repository;
  final GeofencePolicy _geofence;

  Future<Result<DrivingRoute>> call({
    required GautrainStation origin,
    required LatLng destination,
  }) async {
    if (!_geofence.allows(station: origin.location, destination: destination)) {
      return Err(
        OutsideServiceAreaFailure(
          '$destination is more than ${_geofence.radiusMeters}m from '
          '${origin.name}',
        ),
      );
    }
    return _repository.getRoute(origin.location, destination);
  }
}
