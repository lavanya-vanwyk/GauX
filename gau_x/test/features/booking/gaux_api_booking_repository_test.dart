import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:gau_x/core/domain/failure.dart';
import 'package:gau_x/core/domain/result.dart';
import 'package:gau_x/core/network/api_client.dart';
import 'package:gau_x/features/booking/data/datasources/gaux_api_datasource.dart';
import 'package:gau_x/features/booking/data/datasources/mock_stations_datasource.dart';
import 'package:gau_x/features/booking/data/repositories/gaux_api_booking_repository.dart';
import 'package:gau_x/features/booking/domain/entities/driving_route.dart';
import 'package:gau_x/features/booking/domain/entities/gautrain_station.dart';
import 'package:gau_x/features/booking/domain/entities/place_suggestion.dart';
import 'package:gaux_contracts/gaux_contracts.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:latlong2/latlong.dart';

GauxApiBookingRepository _repository(MockClientHandler handler) =>
    GauxApiBookingRepository(
      api: GauxApiDatasource(
        client: ApiClient(httpClient: MockClient(handler)),
        baseUrl: 'https://api.test',
      ),
    );

http.Response _json(Object body, [int status = 200]) =>
    http.Response(jsonEncode(body), status);

void main() {
  const from = LatLng(-26.1075, 28.0567);
  const to = LatLng(-26.0975, 28.0567);

  test(
    'routes come from /v1/route with the server-measured distance',
    () async {
      late Uri requested;
      final repository = _repository((request) async {
        requested = request.url;
        return _json(
          const RouteResponse(
            points: [
              GeoPoint(lat: -26.1075, lng: 28.0567),
              GeoPoint(lat: -26.0975, lng: 28.0567),
            ],
            distanceMeters: 1106,
          ).toJson(),
        );
      });

      final result = await repository.getRoute(from, to);

      expect((result as Success<DrivingRoute>).value.points, [from, to]);
      expect(result.value.distanceMeters, 1106);
      expect(requested.path, '/v1/route');
      expect(requested.queryParameters, {
        'from': '-26.1075,28.0567',
        'to': '-26.0975,28.0567',
      });
    },
  );

  test('a 404 means no route', () async {
    final repository = _repository(
      (_) async => _json({'code': 'not_found', 'message': 'x'}, 404),
    );

    final result = await repository.getRoute(from, to);

    expect((result as Err).failure, isA<NotFoundFailure>());
  });

  test('a 502 is reported as a server failure', () async {
    final repository = _repository(
      (_) async => _json({'code': 'upstream_unavailable', 'message': 'x'}, 502),
    );

    final result = await repository.getRoute(from, to);

    expect(
      (result as Err).failure,
      isA<ServerFailure>().having((f) => f.statusCode, 'statusCode', 502),
    );
  });

  test('places come from /v1/places', () async {
    final repository = _repository(
      (_) async => _json(
        const PlacesResponse(
          places: [
            PlaceDto(
              name: 'Rosebank',
              location: GeoPoint(lat: -26.14, lng: 28.04),
            ),
          ],
        ).toJson(),
      ),
    );

    final result = await repository.searchPlaces('Rosebank');

    expect((result as Success<List<PlaceSuggestion>>).value, [
      const PlaceSuggestion(name: 'Rosebank', location: LatLng(-26.14, 28.04)),
    ]);
  });

  test('stations come from the API', () async {
    final repository = _repository(
      (_) async => _json(
        const StationsResponse(
          stations: [
            StationDto(id: 'x', name: 'X', location: GeoPoint(lat: 1, lng: 2)),
          ],
        ).toJson(),
      ),
    );

    final stations = (await repository.getStations()).valueOrNull;

    expect(stations, [
      const GautrainStation(id: 'x', name: 'X', location: LatLng(1, 2)),
    ]);
  });

  test('stations fall back to the bundled list when the API is down', () async {
    final repository = _repository((_) async => http.Response('', 503));

    final stations = (await repository.getStations()).valueOrNull;

    expect(stations, MockStationsDatasource.stations);
  });
}
