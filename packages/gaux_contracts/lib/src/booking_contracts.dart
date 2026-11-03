import 'package:freezed_annotation/freezed_annotation.dart';

import 'geo_point.dart';

part 'booking_contracts.freezed.dart';
part 'booking_contracts.g.dart';

/// `GET /v1/route?from=lat,lng&to=lat,lng`
@freezed
abstract class RouteResponse with _$RouteResponse {
  const factory RouteResponse({
    required List<GeoPoint> points,

    /// Length of [points] in metres, measured along the geometry.
    required double distanceMeters,
  }) = _RouteResponse;

  factory RouteResponse.fromJson(Map<String, dynamic> json) =>
      _$RouteResponseFromJson(json);
}

/// One result of `GET /v1/places?q=...&limit=...`.
@freezed
abstract class PlaceDto with _$PlaceDto {
  const factory PlaceDto({required String name, required GeoPoint location}) =
      _PlaceDto;

  factory PlaceDto.fromJson(Map<String, dynamic> json) =>
      _$PlaceDtoFromJson(json);
}

@freezed
abstract class PlacesResponse with _$PlacesResponse {
  const factory PlacesResponse({required List<PlaceDto> places}) =
      _PlacesResponse;

  factory PlacesResponse.fromJson(Map<String, dynamic> json) =>
      _$PlacesResponseFromJson(json);
}

@freezed
abstract class StationDto with _$StationDto {
  const factory StationDto({
    required String id,
    required String name,
    required GeoPoint location,
  }) = _StationDto;

  factory StationDto.fromJson(Map<String, dynamic> json) =>
      _$StationDtoFromJson(json);
}

/// `GET /v1/stations`
@freezed
abstract class StationsResponse with _$StationsResponse {
  const factory StationsResponse({required List<StationDto> stations}) =
      _StationsResponse;

  factory StationsResponse.fromJson(Map<String, dynamic> json) =>
      _$StationsResponseFromJson(json);
}
