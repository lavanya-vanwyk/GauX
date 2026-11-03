import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'osrm_route_response.freezed.dart';
part 'osrm_route_response.g.dart';

/// The subset of an OSRM `/route` response (with `geometries=geojson`) that
/// GauX reads. See https://project-osrm.org/docs/v5.24.0/api/#route-service
@freezed
abstract class OsrmRouteResponse with _$OsrmRouteResponse {
  const factory OsrmRouteResponse({
    @Default(<OsrmRoute>[]) List<OsrmRoute> routes,
  }) = _OsrmRouteResponse;

  factory OsrmRouteResponse.fromJson(Map<String, dynamic> json) =>
      _$OsrmRouteResponseFromJson(json);
}

@freezed
abstract class OsrmRoute with _$OsrmRoute {
  const factory OsrmRoute({required OsrmGeometry geometry}) = _OsrmRoute;

  factory OsrmRoute.fromJson(Map<String, dynamic> json) =>
      _$OsrmRouteFromJson(json);
}

@freezed
abstract class OsrmGeometry with _$OsrmGeometry {
  const OsrmGeometry._();

  /// GeoJSON order: `[longitude, latitude]`.
  const factory OsrmGeometry({required List<List<double>> coordinates}) =
      _OsrmGeometry;

  factory OsrmGeometry.fromJson(Map<String, dynamic> json) =>
      _$OsrmGeometryFromJson(json);

  List<LatLng> toLatLngs() =>
      coordinates.map((pair) => LatLng(pair[1], pair[0])).toList();
}
