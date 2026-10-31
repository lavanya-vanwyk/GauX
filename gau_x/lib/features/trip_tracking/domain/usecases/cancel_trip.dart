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

  /// What cancelling now would cost. Free until the rider is in the car.
  double feeFor(
    RideQuote quote, {
    required bool inTransit,
    required double distanceCoveredMeters,
  }) {
    if (!inTransit) return 0;
    return _fares.partialFare(
      quote,
      distanceCoveredMeters: distanceCoveredMeters,
    );
  }

  /// Charges [fee] (from [feeFor]) and returns it.
  Future<double> call(RideQuote quote, {required double fee}) async {
    if (fee > 0) {
      await _payments.charge(
        amount: fee,
        description: 'Canceled: ${quote.rideType.displayName}',
      );
    }
    return fee;
  }
}
