import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LiveMapCanvas extends StatefulWidget {
  final bool isFreeRoam;
  const LiveMapCanvas({super.key, this.isFreeRoam = false});

  @override
  State<LiveMapCanvas> createState() => _LiveMapCanvasState();
}

class _LiveMapCanvasState extends State<LiveMapCanvas> {
  final MapController _mapController = MapController();
  final ValueNotifier<LatLng> _currentLocation = ValueNotifier(const LatLng(-26.1080, 28.0556));
  final List<LatLng> _routePoints = [];
  Timer? _walkTimer;
  int _currentRouteIndex = 0;

  @override
  void dispose() {
    _walkTimer?.cancel();
    _currentLocation.dispose();
    _mapController.dispose();
    super.dispose();
  }

  void _stopDebugWalk() {
    _walkTimer?.cancel();
  }

  void _updateLocation(LatLng newPos) {
    _currentLocation.value = newPos;
    if (widget.isFreeRoam) {
      _mapController.move(newPos, 16);
    }
  }

  void _startDebugWalk() {
    _walkTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_currentRouteIndex >= _routePoints.length - 1) {
        _stopDebugWalk();
        return;
      }
      if (!mounted) return;

      _currentRouteIndex++;
      LatLng newPos = _routePoints[_currentRouteIndex];

      _updateLocation(newPos);
      _mapController.move(newPos, 16);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: _currentLocation.value,
        initialZoom: 16.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.gaux',
        ),
        if (_routePoints.isNotEmpty)
          PolylineLayer(
            polylines: [
              Polyline(
                points: _routePoints,
                strokeWidth: 5.0,
                color: Colors.blueAccent,
              ),
            ],
          ),
        ValueListenableBuilder<LatLng>(
          valueListenable: _currentLocation,
          builder: (context, location, child) {
            return MarkerLayer(
              markers: [
                Marker(
                  point: location,
                  width: 80,
                  height: 80,
                  child: const Icon(
                    Icons.person_pin_circle,
                    color: Colors.redAccent,
                    size: 40,
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}