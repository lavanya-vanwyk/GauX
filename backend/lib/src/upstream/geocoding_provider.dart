import 'dart:async';
import 'dart:convert';

import 'package:gaux_backend/src/upstream/upstream_exception.dart';
import 'package:gaux_contracts/gaux_contracts.dart';
import 'package:http/http.dart' as http;

/// Place search from some geocoder.
abstract interface class GeocodingProvider {
  /// Up to [limit] places matching [query]; empty when nothing matches.
  ///
  /// Throws [UpstreamException] if the geocoder is unreachable or misbehaves.
  Future<List<PlaceDto>> search(String query, {required int limit});
}

/// Nominatim's `/search?format=json`.
class NominatimGeocodingProvider implements GeocodingProvider {
  NominatimGeocodingProvider({
    required http.Client client,
    required this.baseUrl,
    required this.userAgent,
    this.timeout = const Duration(seconds: 10),
  }) : _client = client;

  final http.Client _client;
  final String baseUrl;
  final String userAgent;
  final Duration timeout;

  @override
  Future<List<PlaceDto>> search(String query, {required int limit}) async {
    final url = Uri.parse(baseUrl).replace(
      queryParameters: {
        'q': query,
        'format': 'json',
        'addressdetails': '1',
        'limit': '$limit',
      },
    );

    final http.Response response;
    try {
      response = await _client
          .get(url, headers: {'User-Agent': userAgent})
          .timeout(timeout);
    } on TimeoutException {
      throw const UpstreamException('nominatim', 'timed out');
    } on http.ClientException catch (e) {
      throw UpstreamException('nominatim', e.message);
    }
    if (response.statusCode != 200) {
      throw UpstreamException('nominatim', 'HTTP ${response.statusCode}');
    }

    try {
      final results = jsonDecode(response.body) as List<dynamic>;
      return [
        for (final item in results.cast<Map<String, dynamic>>())
          PlaceDto(
            // Drop the trailing ", Gauteng, <postcode>, South Africa"
            name: (item['display_name'] as String).split(', Gauteng').first,
            location: GeoPoint(
              lat: double.parse(item['lat'].toString()),
              lng: double.parse(item['lon'].toString()),
            ),
          ),
      ];
    } on FormatException catch (e) {
      throw UpstreamException('nominatim', 'bad response: ${e.message}');
      // The JSON casts above throw TypeError on an unexpected shape
      // ignore: avoid_catching_errors
    } on TypeError catch (e) {
      throw UpstreamException('nominatim', 'unexpected shape: $e');
    }
  }
}
