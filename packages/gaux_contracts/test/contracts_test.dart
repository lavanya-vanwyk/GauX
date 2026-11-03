import 'dart:convert';

import 'package:gaux_contracts/gaux_contracts.dart';
import 'package:test/test.dart';

/// Encodes to a JSON string and back, as the API does.
T roundTrip<T>(T value, T Function(Map<String, dynamic>) fromJson) =>
    fromJson(jsonDecode(jsonEncode(value)) as Map<String, dynamic>);

void main() {
  const sandton = GeoPoint(lat: -26.1075, lng: 28.0567);

  test('responses survive a JSON round trip', () {
    const route = RouteResponse(points: [sandton], distanceMeters: 1200);
    const places = PlacesResponse(
      places: [PlaceDto(name: 'Sandton City', location: sandton)],
    );
    const stations = StationsResponse(
      stations: [StationDto(id: 'sandton', name: 'Sandton', location: sandton)],
    );

    expect(roundTrip(route, RouteResponse.fromJson), route);
    expect(roundTrip(places, PlacesResponse.fromJson), places);
    expect(roundTrip(stations, StationsResponse.fromJson), stations);
  });

  group('RemoteConfig', () {
    test('an empty document gives the default config', () {
      final config = RemoteConfig.fromJson(const {});

      expect(config, const RemoteConfig());
      expect(config.pricing.privateBaseFare, 10.0);
      expect(config.serviceArea.radiusMeters, 5000.0);
      expect(config.flags.bookingEnabled, isTrue);
    });

    test('partial documents keep defaults for missing keys', () {
      final config = RemoteConfig.fromJson(const {
        'version': 7,
        'pricing': {'poolFlatFare': 30},
        'flags': {'sosEnabled': false},
      });

      expect(config.version, 7);
      expect(config.pricing.poolFlatFare, 30.0);
      expect(config.pricing.privatePerKm, 12.0);
      expect(config.flags.sosEnabled, isFalse);
      expect(config.flags.bookingEnabled, isTrue);
    });

    test('ignores keys it does not know', () {
      final config = RemoteConfig.fromJson(const {'futureField': 'x'});

      expect(config, const RemoteConfig());
    });

    test('survives a JSON round trip', () {
      const config = RemoteConfig(
        version: 3,
        flags: FeatureFlags(bookingEnabled: false),
      );

      expect(roundTrip(config, RemoteConfig.fromJson), config);
    });
  });

  group('GeoPoint.tryParse', () {
    test('reads "lat,lng"', () {
      expect(GeoPoint.tryParse('-26.1075, 28.0567'), sandton);
      expect(GeoPoint.tryParse(sandton.toQuery()), sandton);
    });

    test('rejects malformed or out-of-range values', () {
      for (final value in [null, '', '1', '1,2,3', 'a,b', '91,0', '0,181']) {
        expect(GeoPoint.tryParse(value), isNull, reason: value);
      }
    });
  });

  group('Fares (cents)', () {
    const pricing = PricingConfig();

    test('match the hackathon pricing', () {
      expect(Fares.fareCents(pricing, RideKind.private, 2500), 4000);
      expect(Fares.fareCents(pricing, RideKind.pool, 4800), 2500);
      expect(Fares.etaMinutes(pricing, 2500), 7);
    });

    test('round to the nearest cent', () {
      // R10 + 1.2345 km × R12 = R24.814
      expect(Fares.fareCents(pricing, RideKind.private, 1234.5), 2481);
      // R25 × 1/3
      expect(
        Fares.cancellationCents(
          pricing,
          RideKind.pool,
          plannedMeters: 3000,
          coveredMeters: 1000,
        ),
        833,
      );
    });

    test('a cancellation never costs more than the full fare', () {
      expect(
        Fares.cancellationCents(
          pricing,
          RideKind.private,
          plannedMeters: 2000,
          coveredMeters: 999999,
        ),
        Fares.fareCents(pricing, RideKind.private, 2000),
      );
      expect(
        Fares.cancellationCents(
          pricing,
          RideKind.private,
          plannedMeters: 2000,
          coveredMeters: -50,
        ),
        1000,
      );
    });

    test('a zero-length pool ride cancels for free', () {
      expect(
        Fares.cancellationCents(
          pricing,
          RideKind.pool,
          plannedMeters: 0,
          coveredMeters: 0,
        ),
        0,
      );
    });
  });

  test('wallet and quote models survive a JSON round trip', () {
    final quote = QuoteResponse(
      id: 'q1',
      rideType: RideKind.pool,
      distanceMeters: 1200,
      fareCents: 2500,
      etaMinutes: 3,
      expiresAt: DateTime.utc(2026, 11, 2, 12),
    );
    final wallet = WalletResponse(
      balanceCents: 32500,
      entries: [
        WalletEntryDto(
          id: 'e1',
          kind: 'ride_charge',
          description: 'GauX Pool',
          amountCents: -2500,
          createdAt: DateTime.utc(2026, 11, 2, 12),
        ),
      ],
    );

    expect(roundTrip(quote, QuoteResponse.fromJson), quote);
    expect(roundTrip(wallet, WalletResponse.fromJson), wallet);
    expect(
      roundTrip(
        const QuoteRequest(
          from: sandton,
          to: sandton,
          rideType: RideKind.private,
        ),
        QuoteRequest.fromJson,
      ).rideType,
      RideKind.private,
    );
  });
}
