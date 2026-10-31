import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import '../config/app_config.dart';

class MockDirectionsClient {
  Future<List<LatLng>> getRoute(LatLng startCoord, LatLng endCoord) async {
    final url = Uri.parse(
      '${AppConfig.osrmBaseUrl}/route/v1/driving/'
      '${startCoord.longitude},${startCoord.latitude};'
      '${endCoord.longitude},${endCoord.latitude}'
      '?overview=full&geometries=geojson',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final routes = data['routes'] as List<dynamic>?;

        if (routes != null && routes.isNotEmpty) {
          final route = routes.first as Map<String, dynamic>;
          final geometry = route['geometry'] as Map<String, dynamic>;
          final coordinates = geometry['coordinates'] as List<dynamic>;

          return coordinates.map((point) {
            final pair = point as List<dynamic>;
            return LatLng(
              (pair[1] as num).toDouble(),
              (pair[0] as num).toDouble(),
            );
          }).toList();
        }
      }
      // TODO(phase-1): return typed failures instead of swallowing errors.
    } on Object catch (e) {
      debugPrint('Error fetching route: $e');
    }
    return [];
  }
}
