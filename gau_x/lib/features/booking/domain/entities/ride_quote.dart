import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/ride_type.dart';

part 'ride_quote.freezed.dart';

/// The price and estimate shown to the rider before they confirm.
///
/// Calculated on the device for now; a pricing backend will issue these
/// later (surge, promotions), at which point `RideQuoteModel` maps its
/// response to this entity.
@freezed
abstract class RideQuote with _$RideQuote {
  const factory RideQuote({
    required RideType rideType,
    required double distanceKm,
    required int etaMinutes,
    required double fare,
  }) = _RideQuote;
}
