import '../../../../core/domain/result.dart';
import '../../../booking/domain/entities/ride_quote.dart';
import '../../../booking/domain/policies/fare_calculator.dart';
import '../ports/trip_payment_port.dart';

/// Cancels a trip, charging for the distance already driven.
class CancelTrip {
  const CancelTrip({
    required TripPaymentPort payments,
    FareCalculator fares = const FareCalculator(),
  }) : _payments = payments,
       _fares = fares;

  final TripPaymentPort _payments;
  final FareCalculator _fares;

  /// What cancelling now would cost, in cents. Free until the rider is in
  /// the car. Uses the same rules the server charges with.
  int feeFor(
    RideQuote quote, {
    required bool inTransit,
    required double distanceCoveredMeters,
  }) {
    if (!inTransit) return 0;
    return _fares.cancellationCents(
      quote,
      distanceCoveredMeters: distanceCoveredMeters,
    );
  }

  /// Charges for [distanceCoveredMeters] and returns the cents charged.
  /// Nothing is charged before pickup.
  Future<Result<int>> call(
    RideQuote quote, {
    required bool inTransit,
    required double distanceCoveredMeters,
  }) async {
    if (!inTransit) return const Success(0);
    return _payments.chargeCancelled(
      quote,
      distanceCoveredMeters: distanceCoveredMeters,
    );
  }
}
