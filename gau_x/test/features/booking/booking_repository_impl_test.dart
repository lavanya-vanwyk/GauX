import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:gau_x/core/domain/failure.dart';
import 'package:gau_x/core/domain/result.dart';
import 'package:gau_x/core/network/api_client.dart';
import 'package:gau_x/features/booking/data/datasources/geocoding_remote_datasource.dart';
import 'package:gau_x/features/booking/data/datasources/mock_stations_datasource.dart';
import 'package:gau_x/features/booking/data/datasources/routing_remote_datasource.dart';
import 'package:gau_x/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:gau_x/features/booking/domain/entities/driving_route.dart';
import 'package:gau_x/features/booking/domain/entities/place_suggestion.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:latlong2/latlong.dart';

BookingRepositoryImpl _repository(
  MockClientHandler handler, {
  Duration timeout = const Duration(seconds: 10),
}) {
  final api = ApiClient(httpClient: MockClient(handler), timeout: timeout);
  return BookingRepositoryImpl(
    routing: RoutingRemoteDatasource(client: api, baseUrl: 'https://osrm.test'),
    geocoding: GeocodingRemoteDatasource(
      client: api,
      baseUrl: 'https://nominatim.test/search',
    ),
    stations: const MockStationsDatasource(),
  );
}

http.Response _json(Object body, [int status = 200]) =>
    http.Response(jsonEncode(body), status);

void main() {
  const from = LatLng(-26.1075, 28.0567);
  const to = LatLng(-26.0975, 28.0567);

  group('getRoute', () {
    test('maps GeoJSON [lon, lat] pairs to a route', () async {
      late Uri requested;
      final repository = _repository((request) async {
        requested = request.url;
        return _json({
          'code': 'Ok',
          'routes': [
            {
              'distance': 9999, // ignored: distance comes from the geometry
              'geometry': {
                'coordinates': [
                  [28.0567, -26.1075],
                  [28.0567, -26.0975],
                ],
              },
            },
          ],
        });
      });

      final result = await repository.getRoute(from, to);

      final route = (result as Success<DrivingRoute>).value;
      expect(route.points, [from, to]);
      expect(route.distanceMeters, closeTo(1106, 5));
      expect(
        requested.toString(),
        startsWith(
          'https://osrm.test/route/v1/driving/28.0567,-26.1075;28.0567,-26.0975',
        ),
      );
    });

    test('reports NotFoundFailure when OSRM finds no route', () async {
      final repository = _repository(
        (_) async => _json({'code': 'NoRoute', 'routes': <Object>[]}),
      );

      final result = await repository.getRoute(from, to);

      expect((result as Err).failure, isA<NotFoundFailure>());
    });

    test('reports ServerFailure on an error status', () async {
      final repository = _repository((_) async => http.Response('busy', 503));

      final result = await repository.getRoute(from, to);

      expect(
        (result as Err).failure,
        isA<ServerFailure>().having((f) => f.statusCode, 'statusCode', 503),
      );
    });

    test('reports ParsingFailure on an unexpected shape', () async {
      final repository = _repository(
        (_) async => _json({
          'routes': [
            {'geometry': 'not-geojson'},
          ],
        }),
      );

      final result = await repository.getRoute(from, to);

      expect((result as Err).failure, isA<ParsingFailure>());
    });

    test('reports NetworkFailure when the connection fails', () async {
      final repository = _repository(
        (_) async => throw http.ClientException('no route to host'),
      );

      final result = await repository.getRoute(from, to);

      expect((result as Err).failure, isA<NetworkFailure>());
    });

    test('reports NetworkFailure on timeout', () async {
      final repository = _repository(
        (_) => Completer<http.Response>().future,
        timeout: const Duration(milliseconds: 10),
      );

      final result = await repository.getRoute(from, to);

      expect((result as Err).failure, isA<NetworkFailure>());
    });
  });

  group('searchPlaces', () {
    test('parses string coordinates and trims the region', () async {
      late http.Request sent;
      final repository = _repository((request) async {
        sent = request;
        return _json([
          {
            'display_name':
                'Rosebank Mall, Rosebank, Johannesburg, Gauteng, 2196, '
                'South Africa',
            'lat': '-26.1452',
            'lon': '28.0436',
          },
        ]);
      });

      final result = await repository.searchPlaces('Rosebank', limit: 3);

      expect((result as Success<List<PlaceSuggestion>>).value, [
        const PlaceSuggestion(
          name: 'Rosebank Mall, Rosebank, Johannesburg',
          location: LatLng(-26.1452, 28.0436),
        ),
      ]);
      expect(sent.url.queryParameters, containsPair('q', 'Rosebank'));
      expect(sent.url.queryParameters, containsPair('limit', '3'));
      expect(sent.headers, containsPair('User-Agent', 'GauX_App'));
    });

    test('reports ParsingFailure for non-numeric coordinates', () async {
      final repository = _repository(
        (_) async => _json([
          {'display_name': 'Nowhere', 'lat': 'north', 'lon': 'east'},
        ]),
      );

      final result = await repository.searchPlaces('Nowhere');

      expect((result as Err).failure, isA<ParsingFailure>());
    });
  });
}
