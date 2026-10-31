import 'package:latlong2/latlong.dart';

import '../../../../core/domain/result.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/json_parsing.dart';
import '../models/osrm_route_response.dart';

/// Fetches driving routes from an OSRM server.
class RoutingRemoteDatasource {
  const RoutingRemoteDatasource({
    required ApiClient client,
    required String baseUrl,
  }) : _client = client,
       _baseUrl = baseUrl;

  final ApiClient _client;
  final String _baseUrl;

  Future<Result<OsrmRouteResponse>> fetchRoute(LatLng from, LatLng to) async {
    final url = Uri.parse(
      '$_baseUrl/route/v1/driving/'
      '${from.longitude},${from.latitude};${to.longitude},${to.latitude}'
      '?overview=full&geometries=geojson',
    );
    final response = await _client.getJson(url);
    return parseJson(response, (json) {
      return OsrmRouteResponse.fromJson(json as Map<String, dynamic>);
    });
  }
}
