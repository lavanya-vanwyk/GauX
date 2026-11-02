import 'package:gaux_contracts/gaux_contracts.dart';

import '../../../../core/domain/ride_type.dart';
import '../entities/ride_quote.dart';

/// Prices rides with the shared GauX fare rules ([Fares]) and the current
/// [pricing], so the app shows exactly what the server will charge.
class FareCalculator {
  const FareCalculator([this.pricing = const PricingConfig()]);

  final PricingConfig pricing;

  RideQuote quote({
    required RideType rideType,
    required double distanceMeters,
  }) {
    return RideQuote(
      rideType: rideType,
      distanceMeters: distanceMeters,
      etaMinutes: Fares.etaMinutes(pricing, distanceMeters),
      fareCents: Fares.fareCents(pricing, rideType.kind, distanceMeters),
    );
  }

  /// What cancelling after [distanceCoveredMeters] costs, in cents. Never
  /// more than the full fare.
  int cancellationCents(
    RideQuote quote, {
    required double distanceCoveredMeters,
  }) => Fares.cancellationCents(
    pricing,
    quote.rideType.kind,
    plannedMeters: quote.distanceMeters,
    coveredMeters: distanceCoveredMeters,
  );
}
