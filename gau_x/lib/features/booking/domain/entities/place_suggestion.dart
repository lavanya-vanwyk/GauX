import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'place_suggestion.freezed.dart';

/// A named place the user can pick as a destination.
@freezed
abstract class PlaceSuggestion with _$PlaceSuggestion {
  const factory PlaceSuggestion({
    required String name,
    required LatLng location,
  }) = _PlaceSuggestion;
}
