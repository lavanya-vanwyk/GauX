import '../../../booking/domain/entities/ride_quote.dart';
import '../ports/trip_payment_port.dart';

/// Charges the quoted fare when the rider arrives.
class CompleteTrip {
  const CompleteTrip({required TripPaymentPort payments})
    : _payments = payments;

  final TripPaymentPort _payments;

  Future<void> call(RideQuote quote) => _payments.charge(
    amount: quote.fare,
    description: quote.rideType.displayName,
  );
}
