import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../domain/failure.dart';
import '../domain/result.dart';

/// The rider's location is unavailable: permission denied, location
/// services off, or no fix in time.
final class LocationUnavailableFailure extends Failure {
  const LocationUnavailableFailure(super.message);
}

/// The device's current position, asking for permission when needed.
abstract interface class LocationService {
  Future<Result<LatLng>> currentPosition();
}

class GeolocatorLocationService implements LocationService {
  const GeolocatorLocationService({
    this.timeLimit = const Duration(seconds: 10),
  });

  final Duration timeLimit;

  @override
  Future<Result<LatLng>> currentPosition() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        return const Err(LocationUnavailableFailure('Location services off'));
      }

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission
          case LocationPermission.denied || LocationPermission.deniedForever) {
        return Err(LocationUnavailableFailure('Permission $permission'));
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.medium,
          timeLimit: timeLimit,
        ),
      );
      return Success(LatLng(position.latitude, position.longitude));
    } on Exception catch (e) {
      // Timeouts, platform errors and missing plugins on unsupported hosts
      return Err(LocationUnavailableFailure('$e'));
    }
  }
}
