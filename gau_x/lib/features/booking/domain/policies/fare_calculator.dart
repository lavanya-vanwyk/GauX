import '../../../../core/domain/ride_type.dart';
import '../entities/ride_quote.dart';

/// GauX pricing rules, in rand.
///
/// - Private: a base fare plus a per-kilometre rate.
/// - Pool: a flat fare, whatever the distance.
/// - ETA assumes an average city speed.
class FareCalculator {
  const FareCalculator({
    this.privateBaseFare = 10.0,
    this.privatePerKm = 12.0,
    this.poolFlatFare = 25.0,
    this.averageMetersPerMinute = 400.0,
  });

  final double privateBaseFare;
  final double privatePerKm;
  final double poolFlatFare;
  final double averageMetersPerMinute;

  RideQuote quote({
    required RideType rideType,
    required double distanceMeters,
  }) {
    final distanceKm = distanceMeters / 1000.0;
    return RideQuote(
      rideType: rideType,
      distanceKm: distanceKm,
      etaMinutes: (distanceMeters / averageMetersPerMinute).ceil(),
      fare: switch (rideType) {
        RideType.pool => poolFlatFare,
        RideType.private => privateBaseFare + distanceKm * privatePerKm,
      },
    );
  }

  /// What to charge when a ride is cancelled after [distanceCoveredMeters].
  ///
  /// Pool charges the share of the flat fare matching the share of the trip
  /// completed. Private charges the base fare plus the distance covered.
  double partialFare(RideQuote quote, {required double distanceCoveredMeters}) {
    final coveredKm = distanceCoveredMeters / 1000.0;
    final fare = switch (quote.rideType) {
      RideType.pool =>
        quote.distanceKm > 0
            ? poolFlatFare * (coveredKm / quote.distanceKm)
            : 0.0,
      RideType.private => privateBaseFare + coveredKm * privatePerKm,
    };
    return _roundToCents(fare);
  }

  static double _roundToCents(double amount) =>
      double.parse(amount.toStringAsFixed(2));
}
