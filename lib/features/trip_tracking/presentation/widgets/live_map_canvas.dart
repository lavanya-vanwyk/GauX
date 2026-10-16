import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LiveMapCanvas extends StatefulWidget {
  const LiveMapCanvas({super.key});

  @override
  State<LiveMapCanvas> createState() => _LiveMapCanvasState();
}

class _LiveMapCanvasState extends State<LiveMapCanvas> {
  final MapController _mapController = MapController();
  
  // Default location: Sandton Gautrain Station
  final LatLng _defaultStationLocation = const LatLng(-26.1080, 28.0556);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: _defaultStationLocation,
        initialZoom: 16.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.gaux', 
        ),
        // PolylineLayer and MarkerLayer will be injected here during Phase 2/3
      ],
    );
  }
}
