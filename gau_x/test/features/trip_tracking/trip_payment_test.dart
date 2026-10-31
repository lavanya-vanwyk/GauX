import 'package:flutter_test/flutter_test.dart';
import 'package:gau_x/core/domain/ride_type.dart';
import 'package:gau_x/features/booking/domain/policies/fare_calculator.dart';
import 'package:gau_x/features/trip_tracking/domain/usecases/cancel_trip.dart';
import 'package:gau_x/features/trip_tracking/domain/usecases/complete_trip.dart';

import '../../helpers/fakes.dart';

void main() {
  const fares = FareCalculator();
  final privateQuote = fares.quote(
    rideType: RideType.private,
    distanceMeters: 3000,
  );

  test('completing a trip charges the quoted fare', () async {
    final payments = RecordingPaymentPort();

    await CompleteTrip(payments: payments)(privateQuote);

    expect(payments.charges.single, (
      amount: 46.0,
      description: 'GauX Private',
    ));
  });

  group('CancelTrip', () {
    test('is free before the rider is picked up', () {
      final cancel = CancelTrip(payments: RecordingPaymentPort());

      expect(
        cancel.feeFor(privateQuote, inTransit: false, distanceCoveredMeters: 0),
        0,
      );
    });

    test('charges the partial fare once in transit', () async {
      final payments = RecordingPaymentPort();
      final cancel = CancelTrip(payments: payments);

      final fee = cancel.feeFor(
        privateQuote,
        inTransit: true,
        distanceCoveredMeters: 1000,
      );
      final charged = await cancel(privateQuote, fee: fee);

      expect(charged, 22.0);
      expect(payments.charges.single, (
        amount: 22.0,
        description: 'Canceled: GauX Private',
      ));
    });

    test('records nothing when the fee is zero', () async {
      final payments = RecordingPaymentPort();

      await CancelTrip(payments: payments)(privateQuote, fee: 0);

      expect(payments.charges, isEmpty);
    });
  });
}
