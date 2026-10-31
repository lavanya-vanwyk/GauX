import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

import '../../domain/entities/place_suggestion.dart';

part 'nominatim_place_model.freezed.dart';
part 'nominatim_place_model.g.dart';

/// One result from Nominatim's `/search?format=json`.
@freezed
abstract class NominatimPlaceModel with _$NominatimPlaceModel {
  const NominatimPlaceModel._();

  const factory NominatimPlaceModel({
    @JsonKey(name: 'display_name') required String displayName,
    // Nominatim sends coordinates as strings.
    @JsonKey(fromJson: _parseDouble) required double lat,
    @JsonKey(fromJson: _parseDouble) required double lon,
  }) = _NominatimPlaceModel;

  factory NominatimPlaceModel.fromJson(Map<String, dynamic> json) =>
      _$NominatimPlaceModelFromJson(json);

  /// Drops the trailing ", Gauteng, …, South Africa" from the display name.
  PlaceSuggestion toEntity() => PlaceSuggestion(
    name: displayName.split(', Gauteng').first,
    location: LatLng(lat, lon),
  );
}

double _parseDouble(Object? value) => double.parse(value.toString());
