import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import '../config/app_config.dart';

class NominatimClient {
  static const _headers = {'User-Agent': 'GauX_App'};

  Future<LatLng?> getCoordinatesFromAddress(String address) async {
    final query = Uri.encodeComponent('$address, Gauteng, South Africa');
    final url = Uri.parse(
      '${AppConfig.nominatimBaseUrl}?q=$query&format=json&limit=1',
    );

    try {
      final response = await http.get(url, headers: _headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        if (data.isNotEmpty) {
          final first = data.first as Map<String, dynamic>;
          return LatLng(
            double.parse(first['lat'].toString()),
            double.parse(first['lon'].toString()),
          );
        }
      }
      // TODO(phase-1): return typed failures instead of swallowing errors.
    } on Object catch (e) {
      debugPrint('Geocoding error: $e');
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> fetchSuggestions(String query) async {
    if (query.trim().isEmpty) return [];

    final encodedQuery = Uri.encodeComponent('$query, Gauteng, South Africa');
    final url = Uri.parse(
      '${AppConfig.nominatimBaseUrl}?q=$encodedQuery&format=json&addressdetails=1&limit=5',
    );

    try {
      final response = await http.get(url, headers: _headers);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        return data.cast<Map<String, dynamic>>().map((item) {
          final rawName = item['display_name'].toString();
          final cleanName = rawName.split(', Gauteng').first;

          return {
            'name': cleanName,
            'lat': double.parse(item['lat'].toString()),
            'lon': double.parse(item['lon'].toString()),
          };
        }).toList();
      }
      // TODO(phase-1): return typed failures instead of swallowing errors.
    } on Object catch (e) {
      debugPrint('Autocomplete error: $e');
    }
    return [];
  }
}
