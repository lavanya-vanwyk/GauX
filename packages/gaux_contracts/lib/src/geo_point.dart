import 'package:freezed_annotation/freezed_annotation.dart';

part 'geo_point.freezed.dart';
part 'geo_point.g.dart';

/// A WGS84 coordinate on the wire. Kept free of map libraries so any client
/// can use the contracts.
@freezed
abstract class GeoPoint with _$GeoPoint {
  const GeoPoint._();

  const factory GeoPoint({required double lat, required double lng}) =
      _GeoPoint;

  factory GeoPoint.fromJson(Map<String, dynamic> json) =>
      _$GeoPointFromJson(json);

  /// Parses `"lat,lng"`, as used in query strings. Returns null if malformed
  /// or out of range.
  static GeoPoint? tryParse(String? value) {
    final parts = value?.split(',');
    if (parts == null || parts.length != 2) return null;
    final lat = double.tryParse(parts[0].trim());
    final lng = double.tryParse(parts[1].trim());
    if (lat == null || lng == null) return null;
    if (lat.abs() > 90 || lng.abs() > 180) return null;
    return GeoPoint(lat: lat, lng: lng);
  }

  /// The `"lat,lng"` form accepted by [tryParse].
  String toQuery() => '$lat,$lng';
}
