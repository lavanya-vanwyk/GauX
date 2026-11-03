import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:gaux_backend/gaux_backend.dart';
import 'package:gaux_contracts/gaux_contracts.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../routes/index.dart' as health;
import '../../routes/v1/_middleware.dart' as v1;
import '../../routes/v1/config.dart' as config;
import '../../routes/v1/places.dart' as places;
import '../../routes/v1/route.dart' as route;
import '../../routes/v1/stations.dart' as stations;

class _MockContext extends Mock implements RequestContext {}

class _FakeRouting implements RoutingProvider {
  RouteResponse? result = const RouteResponse(
    points: [GeoPoint(lat: 1, lng: 2), GeoPoint(lat: 3, lng: 4)],
    distanceMeters: 1500,
  );
  UpstreamException? error;

  @override
  Future<RouteResponse?> route(GeoPoint from, GeoPoint to) async {
    if (error case final e?) throw e;
    return result;
  }
}

class _FakeGeocoding implements GeocodingProvider {
  final queries = <(String, int)>[];
  UpstreamException? error;

  @override
  Future<List<PlaceDto>> search(String query, {required int limit}) async {
    if (error case final e?) throw e;
    queries.add((query, limit));
    return const [
      PlaceDto(name: 'Rosebank', location: GeoPoint(lat: 1, lng: 2)),
    ];
  }
}

void main() {
  late _FakeRouting routing;
  late _FakeGeocoding geocoding;
  late BackendServices services;

  setUp(() {
    routing = _FakeRouting();
    geocoding = _FakeGeocoding();
    services = BackendServices(
      routing: routing,
      geocoding: geocoding,
      remoteConfig: RemoteConfigSource(
        const RemoteConfig(version: 4, flags: FeatureFlags(sosEnabled: false)),
      ),
      rateLimiter: ClientRateLimiter(capacity: 2),
    );
  });

  RequestContext contextFor(
    String path, {
    HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {},
  }) {
    final context = _MockContext();
    when(() => context.request).thenReturn(
      Request(
        method.value,
        Uri.parse('http://localhost$path'),
        headers: headers,
      ),
    );
    when(() => context.read<BackendServices>()).thenReturn(services);
    return context;
  }

  Future<Map<String, dynamic>> jsonOf(Response response) async =>
      jsonDecode(await response.body()) as Map<String, dynamic>;

  test('GET / reports healthy', () async {
    final response = health.onRequest(contextFor('/'));

    expect(response.statusCode, HttpStatus.ok);
    expect(await jsonOf(response), {'status': 'ok'});
  });

  group('GET /v1/route', () {
    test('returns the route', () async {
      final response = await route.onRequest(
        contextFor('/v1/route?from=-26.1,28.05&to=-26.09,28.05'),
      );

      expect(response.statusCode, HttpStatus.ok);
      expect(RouteResponse.fromJson(await jsonOf(response)), routing.result);
    });

    test('rejects malformed coordinates', () async {
      final response = await route.onRequest(
        contextFor('/v1/route?from=nowhere&to=-26.09,28.05'),
      );

      expect(response.statusCode, HttpStatus.badRequest);
      expect((await jsonOf(response))['code'], ApiErrorCode.badRequest);
    });

    test('404s when there is no road route', () async {
      routing.result = null;

      final response = await route.onRequest(
        contextFor('/v1/route?from=1,2&to=3,4'),
      );

      expect(response.statusCode, HttpStatus.notFound);
    });

    test('502s when the router is down', () async {
      routing.error = const UpstreamException('osrm', 'down');

      final response = await route.onRequest(
        contextFor('/v1/route?from=1,2&to=3,4'),
      );

      expect(response.statusCode, HttpStatus.badGateway);
      expect(
        (await jsonOf(response))['code'],
        ApiErrorCode.upstreamUnavailable,
      );
    });

    test('only allows GET', () async {
      final response = await route.onRequest(
        contextFor('/v1/route?from=1,2&to=3,4', method: HttpMethod.post),
      );

      expect(response.statusCode, HttpStatus.methodNotAllowed);
    });
  });

  group('GET /v1/places', () {
    test('passes the trimmed query and limit to the geocoder', () async {
      final response = await places.onRequest(
        contextFor('/v1/places?q=%20Rosebank%20&limit=3'),
      );

      expect(response.statusCode, HttpStatus.ok);
      expect(
        PlacesResponse.fromJson(await jsonOf(response)).places,
        hasLength(1),
      );
      expect(geocoding.queries.single, ('Rosebank', 3));
    });

    test('validates q and limit', () async {
      for (final query in ['', '?q=', '?q=a&limit=0', '?q=a&limit=50']) {
        final response = await places.onRequest(
          contextFor('/v1/places$query'),
        );
        expect(response.statusCode, HttpStatus.badRequest, reason: query);
      }
    });
  });

  test('GET /v1/stations lists all stations', () async {
    final response = stations.onRequest(contextFor('/v1/stations'));

    final body = StationsResponse.fromJson(await jsonOf(response));
    expect(body.stations, hasLength(10));
    expect(body.stations.map((s) => s.id), contains('sandton'));
  });

  group('GET /v1/config', () {
    test('serves the document with an ETag', () async {
      final response = config.onRequest(contextFor('/v1/config'));

      expect(response.statusCode, HttpStatus.ok);
      expect(
        response.headers[HttpHeaders.etagHeader],
        services.remoteConfig.etag,
      );
      final body = RemoteConfig.fromJson(await jsonOf(response));
      expect(body.version, 4);
      expect(body.flags.sosEnabled, isFalse);
    });

    test('answers 304 when the client already has it', () async {
      final response = config.onRequest(
        contextFor(
          '/v1/config',
          headers: {'if-none-match': services.remoteConfig.etag},
        ),
      );

      expect(response.statusCode, HttpStatus.notModified);
      expect(await response.body(), isEmpty);
    });
  });

  group('/v1 rate limiting', () {
    test('429s with Retry-After once a client exceeds its budget', () async {
      final handler = v1.middleware((_) => Response(body: 'ok'));
      final headers = {'x-forwarded-for': '203.0.113.7, 10.0.0.1'};

      final statuses = [
        for (var i = 0; i < 3; i++)
          (await handler(
            contextFor('/v1/stations', headers: headers),
          )).statusCode,
      ];

      expect(statuses, [200, 200, 429]);
      final limited = await handler(
        contextFor('/v1/stations', headers: headers),
      );
      expect(limited.headers[HttpHeaders.retryAfterHeader], isNot('0'));
    });
  });
}
