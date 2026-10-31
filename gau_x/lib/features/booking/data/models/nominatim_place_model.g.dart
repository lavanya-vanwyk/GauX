// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nominatim_place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NominatimPlaceModel _$NominatimPlaceModelFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_NominatimPlaceModel', json, ($checkedConvert) {
      final val = _NominatimPlaceModel(
        displayName: $checkedConvert('display_name', (v) => v as String),
        lat: $checkedConvert('lat', (v) => _parseDouble(v)),
        lon: $checkedConvert('lon', (v) => _parseDouble(v)),
      );
      return val;
    }, fieldKeyMap: const {'displayName': 'display_name'});

Map<String, dynamic> _$NominatimPlaceModelToJson(
  _NominatimPlaceModel instance,
) => <String, dynamic>{
  'display_name': instance.displayName,
  'lat': instance.lat,
  'lon': instance.lon,
};
