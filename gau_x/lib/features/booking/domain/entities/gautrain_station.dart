import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'gautrain_station.freezed.dart';

/// A Gautrain station that GauX vehicles operate from.
///
/// Future fields: operating hours and live Pool/Private fleet capacity.
@freezed
abstract class GautrainStation with _$GautrainStation {
  const factory GautrainStation({
    required String id,
    required String name,
    required LatLng location,
  }) = _GautrainStation;
}
