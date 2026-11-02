import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/ride_type.dart';

part 'ride_quote.freezed.dart';

/// The price and estimate for a ride. Money is integer cents.
///
/// Calculated on the device for display. When the GauX API is configured,
/// the server issues its own quote at confirmation ([serverQuoteId]) and
/// that is what the rider is charged.
@freezed
abstract class RideQuote with _$RideQuote {
  const RideQuote._();

  const factory RideQuote({
    required RideType rideType,
    required double distanceMeters,
    required int etaMinutes,
    required int fareCents,

    /// Set once the server has priced the ride; charges refer to it.
    String? serverQuoteId,
  }) = _RideQuote;

  double get distanceKm => distanceMeters / 1000;
}
