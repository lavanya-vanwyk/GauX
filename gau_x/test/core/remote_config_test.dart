import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gau_x/core/domain/failure.dart';
import 'package:gau_x/core/domain/result.dart';
import 'package:gau_x/core/domain/ride_type.dart';
import 'package:gau_x/core/network/api_client.dart';
import 'package:gau_x/core/remote_config/remote_config_providers.dart';
import 'package:gau_x/core/remote_config/remote_config_repository.dart';
import 'package:gau_x/features/booking/data/datasources/mock_stations_datasource.dart';
import 'package:gau_x/features/booking/di/booking_providers.dart';
import 'package:gau_x/features/booking/domain/policies/geofence_policy.dart';
import 'package:gau_x/features/booking/presentation/state/booking_controller.dart';
import 'package:gau_x/features/trip_tracking/presentation/widgets/ride_status_panel.dart';
import 'package:gaux_contracts/gaux_contracts.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/fakes.dart';
import '../helpers/test_overrides.dart';

/// Storage holding [config] as the cached remote config.
Map<String, Object> cachedConfig(RemoteConfig config) => {
  'remote_config_v1': jsonEncode(config.toJson()),
};

void main() {
  group('RemoteConfigRepository', () {
    late SharedPreferences prefs;
    final requests = <http.Request>[];

    Future<RemoteConfigRepository> repository(
      MockClientHandler handler, {
      Map<String, Object> storage = const {},
    }) async {
      SharedPreferences.setMockInitialValues(storage);
      prefs = await SharedPreferences.getInstance();
      requests.clear();
      return RemoteConfigRepository(
        prefs: prefs,
        client: ApiClient(
          httpClient: MockClient((request) {
            requests.add(request);
            return handler(request);
          }),
        ),
        baseUrl: 'https://api.test',
      );
    }

    test('starts from defaults with nothing cached', () async {
      final repo = await repository((_) async => http.Response('', 500));

      expect(repo.cached(), const RemoteConfig());
    });

    test('stores a fetched document and revalidates with its ETag', () async {
      const latest = RemoteConfig(
        version: 5,
        flags: FeatureFlags(sosEnabled: false),
      );
      final repo = await repository((request) async {
        if (request.headers['If-None-Match'] == '"abc"') {
          return http.Response('', 304);
        }
        return http.Response(
          jsonEncode(latest.toJson()),
          200,
          headers: {'etag': '"abc"'},
        );
      });

      expect((await repo.refresh()).valueOrNull, latest);
      expect(repo.cached(), latest);

      final second = await repo.refresh();
      expect(requests.last.headers['If-None-Match'], '"abc"');
      expect(second.valueOrNull, latest, reason: '304 serves the cached copy');
    });

    test('keeps the cached copy when the API is unreachable', () async {
      const cached = RemoteConfig(version: 3);
      final repo = await repository(
        (_) async => throw http.ClientException('offline'),
        storage: cachedConfig(cached),
      );

      final result = await repo.refresh();

      expect((result as Err).failure, isA<NetworkFailure>());
      expect(repo.cached(), cached);
    });

    test('ignores a corrupt cached copy', () async {
      final repo = await repository(
        (_) async => http.Response('', 500),
        storage: {'remote_config_v1': '{not json'},
      );

      expect(repo.cached(), const RemoteConfig());
    });

    test(
      'rejects a malformed document without overwriting the cache',
      () async {
        const cached = RemoteConfig(version: 3);
        final repo = await repository(
          (_) async => http.Response('{"version": "seven"}', 200),
          storage: cachedConfig(cached),
        );

        final result = await repo.refresh();

        expect((result as Err).failure, isA<ParsingFailure>());
        expect(repo.cached(), cached);
      },
    );

    test('does nothing without an API configured', () async {
      SharedPreferences.setMockInitialValues(
        cachedConfig(const RemoteConfig(version: 9)),
      );
      final repo = RemoteConfigRepository(
        prefs: await SharedPreferences.getInstance(),
      );

      expect((await repo.refresh()).valueOrNull?.version, 9);
    });
  });

  group('config drives the business rules', () {
    test('fares use the configured pricing', () async {
      final container = await testContainer(
        storage: cachedConfig(
          const RemoteConfig(pricing: PricingConfig(poolFlatFare: 30)),
        ),
      );

      final quote = container
          .read(fareCalculatorProvider)
          .quote(rideType: RideType.pool, distanceMeters: 2000);

      expect(quote.fare, 30.0);
    });

    test('the service area uses the configured radius', () async {
      final container = await testContainer(
        overrides: [
          bookingRepositoryProvider.overrideWithValue(FakeBookingRepository()),
        ],
        storage: cachedConfig(
          const RemoteConfig(
            serviceArea: ServiceAreaConfig(radiusMeters: 2000),
          ),
        ),
      );
      const sandton = MockStationsDatasource.sandton;
      // About 3.3 km north: inside the default 5 km, outside 2 km
      final destination = LatLng(
        sandton.location.latitude + 0.03,
        sandton.location.longitude,
      );

      final result = await container.read(planRouteProvider)(
        origin: sandton,
        destination: destination,
      );

      expect((result as Err).failure, isA<OutsideServiceAreaFailure>());
    });
  });

  group('kill switches', () {
    test('switching Pool off moves a Pool booking to Private', () async {
      final repository = _ScriptedConfigRepository();
      final container = await testContainer(
        overrides: [
          remoteConfigRepositoryProvider.overrideWithValue(repository),
        ],
      );
      container
          .read(bookingControllerProvider.notifier)
          .setRideType(RideType.pool);

      repository.next = const RemoteConfig(
        flags: FeatureFlags(poolEnabled: false),
      );
      await container.read(remoteConfigControllerProvider.notifier).refresh();

      expect(
        container.read(bookingControllerProvider).rideType,
        RideType.private,
      );
    });

    Future<void> pumpStatusPanel(
      WidgetTester tester,
      RemoteConfig config,
    ) async {
      final container = await testContainer(storage: cachedConfig(config));
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const MaterialApp(home: Scaffold(body: RideStatusPanel())),
        ),
      );
    }

    testWidgets('SOS shows by default', (tester) async {
      await pumpStatusPanel(tester, const RemoteConfig());

      expect(find.byTooltip('Safety & SOS'), findsOneWidget);
    });

    testWidgets('SOS hides when switched off', (tester) async {
      await pumpStatusPanel(
        tester,
        const RemoteConfig(flags: FeatureFlags(sosEnabled: false)),
      );

      expect(find.byTooltip('Safety & SOS'), findsNothing);
      expect(find.text('Cancel Ride'), findsOneWidget);
    });
  });
}

/// Starts with defaults; each refresh returns [next].
class _ScriptedConfigRepository implements RemoteConfigRepository {
  RemoteConfig next = const RemoteConfig();

  @override
  RemoteConfig cached() => const RemoteConfig();

  @override
  Future<Result<RemoteConfig>> refresh() async => Success(next);
}
