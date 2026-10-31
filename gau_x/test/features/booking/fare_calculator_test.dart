import 'package:flutter_test/flutter_test.dart';
import 'package:gau_x/core/domain/ride_type.dart';
import 'package:gau_x/features/booking/domain/policies/fare_calculator.dart';

void main() {
  const fares = FareCalculator();

  group('quote', () {
    test('private is R10 base plus R12 per km', () {
      final quote = fares.quote(
        rideType: RideType.private,
        distanceMeters: 2500,
      );

      expect(quote.fare, 40.0);
      expect(quote.distanceKm, 2.5);
    });

    test('pool is a flat R25 whatever the distance', () {
      expect(
        fares.quote(rideType: RideType.pool, distanceMeters: 4800).fare,
        25.0,
      );
    });

    test('ETA rounds up at 400 m per minute', () {
      final quote = fares.quote(
        rideType: RideType.private,
        distanceMeters: 2500,
      );

      expect(quote.etaMinutes, 7); // 6.25 minutes
    });
  });

  group('partialFare', () {
    test('pool charges the share of the trip completed', () {
      final quote = fares.quote(rideType: RideType.pool, distanceMeters: 4000);

      expect(fares.partialFare(quote, distanceCoveredMeters: 1000), 6.25);
    });

    test('pool charges nothing for a zero-length trip', () {
      final quote = fares.quote(rideType: RideType.pool, distanceMeters: 0);

      expect(fares.partialFare(quote, distanceCoveredMeters: 0), 0);
    });

    test('private charges base fare plus distance covered', () {
      final quote = fares.quote(
        rideType: RideType.private,
        distanceMeters: 4000,
      );

      expect(fares.partialFare(quote, distanceCoveredMeters: 1500), 28.0);
    });

    test('rounds to cents', () {
      final quote = fares.quote(rideType: RideType.pool, distanceMeters: 3000);

      expect(fares.partialFare(quote, distanceCoveredMeters: 1000), 8.33);
    });
  });
}
