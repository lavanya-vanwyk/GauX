import 'remote_config.dart';

/// The ride products, as named on the wire.
enum RideKind { private, pool }

/// GauX fare rules, in integer cents. The app (for display) and the backend
/// (for charging) both use these, so they can't disagree.
abstract final class Fares {
  /// The full fare for a ride of [distanceMeters].
  ///
  /// Private: base fare plus a per-kilometre rate. Pool: a flat fare.
  static int fareCents(
    PricingConfig pricing,
    RideKind kind,
    double distanceMeters,
  ) => switch (kind) {
    RideKind.pool => _cents(pricing.poolFlatFare),
    RideKind.private => _cents(
      pricing.privateBaseFare + distanceMeters / 1000 * pricing.privatePerKm,
    ),
  };

  /// What to charge when a ride is cancelled after [coveredMeters] of a
  /// [plannedMeters] trip. Never more than the full fare.
  ///
  /// Pool charges the share of the flat fare matching the share of the trip
  /// completed. Private charges the base fare plus the distance covered.
  static int cancellationCents(
    PricingConfig pricing,
    RideKind kind, {
    required double plannedMeters,
    required double coveredMeters,
  }) {
    final covered = coveredMeters.clamp(0, plannedMeters).toDouble();
    final fee = switch (kind) {
      RideKind.pool =>
        plannedMeters > 0
            ? _cents(pricing.poolFlatFare * covered / plannedMeters)
            : 0,
      RideKind.private => _cents(
        pricing.privateBaseFare + covered / 1000 * pricing.privatePerKm,
      ),
    };
    final full = fareCents(pricing, kind, plannedMeters);
    return fee < full ? fee : full;
  }

  /// Minutes, rounded up, at the configured average city speed.
  static int etaMinutes(PricingConfig pricing, double distanceMeters) =>
      (distanceMeters / pricing.averageMetersPerMinute).ceil();

  static int _cents(double rand) => (rand * 100).round();
}
