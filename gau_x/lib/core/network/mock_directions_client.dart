final url = Uri.parse(
  'http://router.project-osrm.org/route/v1/foot/'
  '${startCoord.longitude},${startCoord.latitude};'
  '${endCoord.longitude},${endCoord.latitude}'
  '?overview=full&geometries=geojson'
);

final response = await http.get(url);

if (response.statusCode == 200) {
  final data = jsonDecode(response.body);
  
  if (data['routes'] != null && (data['routes'] as List).isNotEmpty) {
    final coordinates = data['routes'][0]['geometry']['coordinates'] as List;
    
    List<LatLng> routePoints = coordinates.map((point) {
      return LatLng(
        (point[1] as num).toDouble(), 
        (point[0] as num).toDouble(),
      );
    }).toList();

    return routePoints;
  }
}
