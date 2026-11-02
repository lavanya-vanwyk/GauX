import 'package:flutter_test/flutter_test.dart';
import 'package:gau_x/app/adapters/local_trip_payments.dart';
import 'package:gau_x/core/domain/result.dart';
import 'package:gau_x/core/domain/ride_type.dart';
import 'package:gau_x/features/booking/domain/policies/fare_calculator.dart';
import 'package:gau_x/features/trip_tracking/domain/ports/trip_payment_port.dart';
import 'package:gau_x/features/trip_tracking/domain/usecases/cancel_trip.dart';
import 'package:gau_x/features/trip_tracking/domain/usecases/complete_trip.dart';
import 'package:gau_x/features/wallet/data/datasources/gold_card_local_datasource.dart';
import 'package:gau_x/features/wallet/data/repositories/local_gold_card_repository.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/fakes.dart';

void main() {
  const fares = FareCalculator();
  const from = LatLng(-26.1075, 28.0567);
  const to = LatLng(-26.0975, 28.0567);
  final privateQuote = fares.quote(
    rideType: RideType.private,
    distanceMeters: 3000,
  );

  test('completing a trip charges the quoted fare', () async {
    final payments = RecordingPaymentPort();

    await CompleteTrip(payments: payments)(privateQuote);

    expect(payments.charges.single, (cents: 4600, description: 'GauX Private'));
  });

  group('CancelTrip', () {
    test('is free before the rider is picked up', () async {
      final payments = RecordingPaymentPort();
      final cancel = CancelTrip(payments: payments);

      expect(
        cancel.feeFor(privateQuote, inTransit: false, distanceCoveredMeters: 0),
        0,
      );
      final charged = await cancel(
        privateQuote,
        inTransit: false,
        distanceCoveredMeters: 500,
      );
      expect(charged.valueOrNull, 0);
      expect(payments.charges, isEmpty);
    });

    test('charges the partial fare once in transit', () async {
      final payments = RecordingPaymentPort();
      final cancel = CancelTrip(payments: payments);

      final charged = await cancel(
        privateQuote,
        inTransit: true,
        distanceCoveredMeters: 1000,
      );

      expect(charged.valueOrNull, 2200);
      expect(payments.charges.single, (
        cents: 2200,
        description: 'Canceled: GauX Private',
      ));
    });
  });

  group('LocalTripPayments (on-device wallet)', () {
    late LocalGoldCardRepository wallet;
    late LocalTripPayments payments;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      wallet = LocalGoldCardRepository(
        local: GoldCardLocalDatasource(await SharedPreferences.getInstance()),
      );
      payments = LocalTripPayments(wallet: wallet, fares: fares);
    });

    Future<int> balance() async =>
        (await wallet.load()).valueOrNull!.balanceCents;

    test('confirms affordable rides at the app quote', () async {
      final result = await payments.confirmPrice(
        privateQuote,
        from: from,
        to: to,
      );

      expect(result.valueOrNull, privateQuote);
    });

    test('refuses rides the wallet cannot cover', () async {
      final expensive = fares.quote(
        rideType: RideType.private,
        distanceMeters: 40000,
      );

      final result = await payments.confirmPrice(expensive, from: from, to: to);

      expect((result as Err).failure, isA<InsufficientFundsFailure>());
    });

    test('charges completed and cancelled rides to the wallet', () async {
      await payments.chargeCompleted(privateQuote);
      final fee = await payments.chargeCancelled(
        privateQuote,
        distanceCoveredMeters: 1000,
      );

      expect(fee.valueOrNull, 2200);
      expect(await balance(), 35000 - 4600 - 2200);
    });
  });
}
