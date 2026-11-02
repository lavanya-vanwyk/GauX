import 'package:gaux_contracts/gaux_contracts.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/domain/result.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/json_parsing.dart';

/// Booking endpoints of the GauX API (`backend/routes/v1`).
class GauxApiDatasource {
  const GauxApiDatasource({required ApiClient client, required String baseUrl})
    : _client = client,
      _baseUrl = baseUrl;

  final ApiClient _client;
  final String _baseUrl;

  Future<Result<RouteResponse>> fetchRoute(LatLng from, LatLng to) async {
    final url = Uri.parse(
      '$_baseUrl/v1/route',
    ).replace(queryParameters: {'from': _point(from), 'to': _point(to)});
    return parseJson(
      await _client.getJson(url),
      (json) => RouteResponse.fromJson(json! as Map<String, dynamic>),
    );
  }

  Future<Result<PlacesResponse>> searchPlaces(
    String query, {
    required int limit,
  }) async {
    final url = Uri.parse(
      '$_baseUrl/v1/places',
    ).replace(queryParameters: {'q': query, 'limit': '$limit'});
    return parseJson(
      await _client.getJson(url),
      (json) => PlacesResponse.fromJson(json! as Map<String, dynamic>),
    );
  }

  Future<Result<StationsResponse>> fetchStations() async {
    return parseJson(
      await _client.getJson(Uri.parse('$_baseUrl/v1/stations')),
      (json) => StationsResponse.fromJson(json! as Map<String, dynamic>),
    );
  }

  static String _point(LatLng p) =>
      GeoPoint(lat: p.latitude, lng: p.longitude).toQuery();
}
