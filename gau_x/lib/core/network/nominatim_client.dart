import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class NominatimClient {
  Future<LatLng?> getCoordinatesFromAddress(String address) async {
    // Append Gauteng context to improve local search accuracy
    final query = Uri.encodeComponent('$address, Gauteng, South Africa');
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=1'
    );

    try {
      // Nominatim requires a User-Agent header
      final response = await http.get(url, headers: {'User-Agent': 'GauX_App'});
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          return LatLng(
            double.parse(data[0]['lat'].toString()),
            double.parse(data[0]['lon'].toString()),
          );
        }
      }
    } catch (e) {
      debugPrint('Geocoding error: $e');
    }
    return null; // Return null if address not found
  }
Future<List<Map<String, dynamic>>> fetchSuggestions(String query) async {
    if (query.trim().isEmpty) return [];
    
    final encodedQuery = Uri.encodeComponent('$query, Gauteng, South Africa');
    final url = Uri.parse('https://nominatim.openstreetmap.org/search?q=$encodedQuery&format=json&addressdetails=1&limit=5');
    
    try {
      final response = await http.get(url, headers: {'User-Agent': 'GauX_App'});
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) {
          // Clean up the display string to remove repetitive country/province data
          String rawName = item['display_name'].toString();
          String cleanName = rawName.split(', Gauteng').first;
          
          return {
            'name': cleanName,
            'lat': double.parse(item['lat'].toString()),
            'lon': double.parse(item['lon'].toString()),
          };
        }).toList();
      }
    } catch (e) {
      debugPrint('Autocomplete error: $e');
    }
    return [];
  }
}