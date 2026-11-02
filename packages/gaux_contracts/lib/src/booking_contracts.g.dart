// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_contracts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RouteResponse _$RouteResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_RouteResponse', json, ($checkedConvert) {
      final val = _RouteResponse(
        points: $checkedConvert(
          'points',
          (v) => (v as List<dynamic>)
              .map((e) => GeoPoint.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
        distanceMeters: $checkedConvert(
          'distanceMeters',
          (v) => (v as num).toDouble(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$RouteResponseToJson(_RouteResponse instance) =>
    <String, dynamic>{
      'points': instance.points.map((e) => e.toJson()).toList(),
      'distanceMeters': instance.distanceMeters,
    };

_PlaceDto _$PlaceDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_PlaceDto', json, ($checkedConvert) {
      final val = _PlaceDto(
        name: $checkedConvert('name', (v) => v as String),
        location: $checkedConvert(
          'location',
          (v) => GeoPoint.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PlaceDtoToJson(_PlaceDto instance) => <String, dynamic>{
  'name': instance.name,
  'location': instance.location.toJson(),
};

_PlacesResponse _$PlacesResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_PlacesResponse', json, ($checkedConvert) {
      final val = _PlacesResponse(
        places: $checkedConvert(
          'places',
          (v) => (v as List<dynamic>)
              .map((e) => PlaceDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$PlacesResponseToJson(_PlacesResponse instance) =>
    <String, dynamic>{
      'places': instance.places.map((e) => e.toJson()).toList(),
    };

_StationDto _$StationDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_StationDto', json, ($checkedConvert) {
      final val = _StationDto(
        id: $checkedConvert('id', (v) => v as String),
        name: $checkedConvert('name', (v) => v as String),
        location: $checkedConvert(
          'location',
          (v) => GeoPoint.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$StationDtoToJson(_StationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location.toJson(),
    };

_StationsResponse _$StationsResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_StationsResponse', json, ($checkedConvert) {
      final val = _StationsResponse(
        stations: $checkedConvert(
          'stations',
          (v) => (v as List<dynamic>)
              .map((e) => StationDto.fromJson(e as Map<String, dynamic>))
              .toList(),
        ),
      );
      return val;
    });

Map<String, dynamic> _$StationsResponseToJson(_StationsResponse instance) =>
    <String, dynamic>{
      'stations': instance.stations.map((e) => e.toJson()).toList(),
    };
