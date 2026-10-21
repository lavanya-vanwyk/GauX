import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class MockDirectionsClient {
  Future<List<LatLng>> getRoute(LatLng startCoord, LatLng endCoord) async {
    final url = Uri.parse(
        'http://router.project-osrm.org/route/v1/driving/'
            '${startCoord.longitude},${startCoord.latitude};'
            '${endCoord.longitude},${endCoord.latitude}'
            '?overview=full&geometries=geojson'
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['routes'] != null && (data['routes'] as List).isNotEmpty) {
          final coordinates = data['routes'][0]['geometry']['coordinates'] as List;

          return coordinates.map((point) {
            return LatLng(
              (point[1] as num).toDouble(),
              (point[0] as num).toDouble(),
            );
          }).toList();
        }
      }
    } catch (e) {
      debugPrint('Error fetching route: $e');
    }
    return [];
  }
}