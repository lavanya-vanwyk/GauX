import '../../../../core/domain/result.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/json_parsing.dart';
import '../models/nominatim_place_model.dart';

/// Searches places with a Nominatim server.
///
/// The public instance allows about one request per second and requires an
/// identifying User-Agent: https://operations.osmfoundation.org/policies/nominatim/
class GeocodingRemoteDatasource {
  const GeocodingRemoteDatasource({
    required ApiClient client,
    required String baseUrl,
  }) : _client = client,
       _baseUrl = baseUrl;

  static const _headers = {'User-Agent': 'GauX_App'};

  final ApiClient _client;
  final String _baseUrl;

  Future<Result<List<NominatimPlaceModel>>> search(
    String query, {
    required int limit,
  }) async {
    final url = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'q': query,
        'format': 'json',
        'addressdetails': '1',
        'limit': '$limit',
      },
    );
    final response = await _client.getJson(url, headers: _headers);
    return parseJson(response, (json) {
      return (json as List<dynamic>)
          .map((e) => NominatimPlaceModel.fromJson(e as Map<String, dynamic>))
          .toList();
    });
  }
}
