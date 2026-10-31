import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'driving_route.freezed.dart';

/// A road route between two points, independent of the routing provider.
@freezed
abstract class DrivingRoute with _$DrivingRoute {
  const factory DrivingRoute({
    required List<LatLng> points,
    required double distanceMeters,
  }) = _DrivingRoute;
}
