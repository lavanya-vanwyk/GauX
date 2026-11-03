// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'osrm_route_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OsrmRouteResponse _$OsrmRouteResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_OsrmRouteResponse', json, ($checkedConvert) {
      final val = _OsrmRouteResponse(
        routes: $checkedConvert(
          'routes',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => OsrmRoute.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const <OsrmRoute>[],
        ),
      );
      return val;
    });

Map<String, dynamic> _$OsrmRouteResponseToJson(_OsrmRouteResponse instance) =>
    <String, dynamic>{
      'routes': instance.routes.map((e) => e.toJson()).toList(),
    };

_OsrmRoute _$OsrmRouteFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_OsrmRoute', json, ($checkedConvert) {
      final val = _OsrmRoute(
        geometry: $checkedConvert(
          'geometry',
          (v) => OsrmGeometry.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$OsrmRouteToJson(_OsrmRoute instance) =>
    <String, dynamic>{'geometry': instance.geometry.toJson()};

_OsrmGeometry _$OsrmGeometryFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_OsrmGeometry', json, ($checkedConvert) {
      final val = _OsrmGeometry(
        coordinates: $checkedConvert(
          'coordinates',
          (v) => (v as List<dynamic>)
              .map(
                (e) => (e as List<dynamic>)
                    .map((e) => (e as num).toDouble())
                    .toList(),
              )
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$OsrmGeometryToJson(_OsrmGeometry instance) =>
    <String, dynamic>{'coordinates': instance.coordinates};
