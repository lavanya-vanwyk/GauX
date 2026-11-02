import 'dart:convert';

import 'package:gaux_backend/gaux_backend.dart';
import 'package:gaux_contracts/gaux_contracts.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

http.Response _json(Object body, [int status = 200]) =>
    http.Response(jsonEncode(body), status);

void main() {
  const from = GeoPoint(lat: -26.1075, lng: 28.0567);
  const to = GeoPoint(lat: -26.0975, lng: 28.0567);

  group('OsrmRoutingProvider', () {
    OsrmRoutingProvider provider(MockClientHandler handler) =>
        OsrmRoutingProvider(
          client: MockClient(handler),
          baseUrl: 'https://osrm.test',
          userAgent: 'GauX-Test',
        );

    test('maps GeoJSON [lng, lat] and measures the geometry', () async {
      late http.Request sent;
      final route = await provider((request) async {
        sent = request;
        return _json({
          'code': 'Ok',
          'routes': [
            {
              'geometry': {
                'coordinates': [
                  [28.0567, -26.1075],
                  [28.0567, -26.0975],
                ],
              },
            },
          ],
        });
      }).route(from, to);

      expect(route?.points, [from, to]);
      expect(route?.distanceMeters, closeTo(1106, 5));
      expect(
        sent.url.path,
        '/route/v1/driving/28.0567,-26.1075;28.0567,-26.0975',
      );
      expect(sent.headers['User-Agent'], 'GauX-Test');
    });

    test('returns null when OSRM has no route', () async {
      final route = await provider(
        (_) async => _json({'code': 'NoRoute'}, 400),
      ).route(from, to);

      expect(route, isNull);
    });

    test('throws UpstreamException on errors and junk', () async {
      for (final response in [
        http.Response('down', 503),
        _json({
          'code': 'Ok',
          'routes': [
            {'geometry': 'x'},
          ],
        }),
      ]) {
        await expectLater(
          provider((_) async => response).route(from, to),
          throwsA(isA<UpstreamException>()),
        );
      }
      await expectLater(
        provider(
          (_) async => throw http.ClientException('dns'),
        ).route(from, to),
        throwsA(isA<UpstreamException>()),
      );
    });
  });

  group('NominatimGeocodingProvider', () {
    NominatimGeocodingProvider provider(MockClientHandler handler) =>
        NominatimGeocodingProvider(
          client: MockClient(handler),
          baseUrl: 'https://nominatim.test/search',
          userAgent: 'GauX-Test',
        );

    test('parses string coordinates and trims the region', () async {
      late http.Request sent;
      final places = await provider((request) async {
        sent = request;
        return _json([
          {
            'display_name': 'Rosebank Mall, Johannesburg, Gauteng, 2196, SA',
            'lat': '-26.1452',
            'lon': '28.0436',
          },
        ]);
      }).search('Rosebank', limit: 3);

      expect(places, [
        const PlaceDto(
          name: 'Rosebank Mall, Johannesburg',
          location: GeoPoint(lat: -26.1452, lng: 28.0436),
        ),
      ]);
      expect(sent.url.queryParameters, containsPair('limit', '3'));
      expect(sent.headers['User-Agent'], 'GauX-Test');
    });

    test('throws UpstreamException on bad coordinates', () async {
      await expectLater(
        provider(
          (_) async => _json([
            {'display_name': 'X', 'lat': 'north', 'lon': 'east'},
          ]),
        ).search('X', limit: 1),
        throwsA(isA<UpstreamException>()),
      );
    });
  });

  group('caching providers', () {
    test('repeat route lookups hit the cache, including "no route"', () async {
      final inner = _CountingRouting(null);
      final routing = CachingRoutingProvider(
        inner,
        ttl: const Duration(minutes: 1),
      );

      await routing.route(from, to);
      await routing.route(from, to);

      expect(inner.calls, 1);
    });

    test('place searches are cached case-insensitively', () async {
      final inner = _CountingGeocoding();
      final geocoding = ThrottledGeocodingProvider(
        inner,
        ttl: const Duration(minutes: 1),
        throttle: RequestThrottle(minInterval: Duration.zero),
      );

      await geocoding.search('Rosebank', limit: 5);
      await geocoding.search(' rosebank ', limit: 5);
      await geocoding.search('Rosebank', limit: 1);

      expect(inner.calls, 2);
    });
  });
}

class _CountingRouting implements RoutingProvider {
  _CountingRouting(this.result);

  final RouteResponse? result;
  int calls = 0;

  @override
  Future<RouteResponse?> route(GeoPoint from, GeoPoint to) async {
    calls++;
    return result;
  }
}

class _CountingGeocoding implements GeocodingProvider {
  int calls = 0;

  @override
  Future<List<PlaceDto>> search(String query, {required int limit}) async {
    calls++;
    return const [];
  }
}
