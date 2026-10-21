import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../booking/presentation/state/booking_notifier.dart';

class LiveMapCanvas extends StatefulWidget {
  final bool isFreeRoam;
  const LiveMapCanvas({super.key, this.isFreeRoam = true});

  @override
  State<LiveMapCanvas> createState() => _LiveMapCanvasState();
}

class _LiveMapCanvasState extends State<LiveMapCanvas> {
  final MapController _mapController = MapController();
  final List<LatLng> _routePoints = [];
  Timer? _walkTimer;
  int _currentRouteIndex = 0;

  @override
  void dispose() {
    _walkTimer?.cancel();
    _mapController.dispose();
    super.dispose();
  }

  void _stopDebugWalk() {
    _walkTimer?.cancel();
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

      if (widget.isFreeRoam) {
        _mapController.move(newPos, 16);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookingNotifier = context.watch<BookingNotifier>();

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: bookingNotifier.origin,
        initialZoom: 16.0,
        onTap: (tapPosition, point) {
          bookingNotifier.setDestination(point);
        },
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
        MarkerLayer(
          markers: [
            Marker(
              point: bookingNotifier.origin,
              width: 60,
              height: 60,
              child: const Icon(
                Icons.train,
                color: AppColors.gautrainGold,
                size: 40,
              ),
            ),
            if (bookingNotifier.destination != null)
              Marker(
                point: bookingNotifier.destination!,
                width: 60,
                height: 60,
                child: const Icon(
                  Icons.location_on,
                  color: AppColors.gautrainNavy,
                  size: 40,
                ),
              ),
          ],
        ),
      ],
    );
  }
}