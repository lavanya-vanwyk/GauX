import 'package:flutter_test/flutter_test.dart';
import 'package:gau_x/core/domain/ride_type.dart';
import 'package:gau_x/features/booking/domain/policies/fare_calculator.dart';
import 'package:gaux_contracts/gaux_contracts.dart';

void main() {
  const fares = FareCalculator();

  group('quote', () {
    test('private is R10 base plus R12 per km, in cents', () {
      final quote = fares.quote(
        rideType: RideType.private,
        distanceMeters: 2500,
      );

      expect(quote.fareCents, 4000);
      expect(quote.distanceKm, 2.5);
    });

    test('pool is a flat R25 whatever the distance', () {
      expect(
        fares.quote(rideType: RideType.pool, distanceMeters: 4800).fareCents,
        2500,
      );
    });

    test('ETA rounds up at 400 m per minute', () {
      final quote = fares.quote(
        rideType: RideType.private,
        distanceMeters: 2500,
      );

      expect(quote.etaMinutes, 7); // 6.25 minutes
    });

    test('uses the configured pricing', () {
      const custom = FareCalculator(
        PricingConfig(privateBaseFare: 15, privatePerKm: 10),
      );

      expect(
        custom
            .quote(rideType: RideType.private, distanceMeters: 2000)
            .fareCents,
        3500,
      );
    });
  });

  group('cancellationCents', () {
    test('pool charges the share of the trip completed', () {
      final quote = fares.quote(rideType: RideType.pool, distanceMeters: 4000);

      expect(fares.cancellationCents(quote, distanceCoveredMeters: 1000), 625);
    });

    test('private charges base fare plus distance covered', () {
      final quote = fares.quote(
        rideType: RideType.private,
        distanceMeters: 4000,
      );

      expect(fares.cancellationCents(quote, distanceCoveredMeters: 1500), 2800);
    });

    test('never exceeds the full fare', () {
      final quote = fares.quote(
        rideType: RideType.private,
        distanceMeters: 2000,
      );

      expect(
        fares.cancellationCents(quote, distanceCoveredMeters: 99999),
        quote.fareCents,
      );
    });
  });
}
