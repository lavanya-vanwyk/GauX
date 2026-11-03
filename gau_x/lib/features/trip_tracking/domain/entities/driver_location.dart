import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'driver_location.freezed.dart';

/// A telemetry sample for the driver on an active trip, whether it comes
/// from the simulator or, later, a live vehicle feed.
@freezed
abstract class DriverLocation with _$DriverLocation {
  const factory DriverLocation({
    required LatLng position,

    /// Metres travelled along the route since the trip started.
    required double totalDistanceCovered,

    /// Compass bearing in degrees, 0 = north.
    @Default(0.0) double heading,
  }) = _DriverLocation;
}
