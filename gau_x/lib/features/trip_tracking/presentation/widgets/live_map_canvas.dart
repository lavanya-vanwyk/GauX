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

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _fitRouteBounds(List<LatLng> routePoints) {
    if (routePoints.isEmpty) return;

    final bounds = LatLngBounds.fromPoints(routePoints);
    _mapController.fitCamera(
      CameraFit.bounds(
        bounds: bounds,
        padding: const EdgeInsets.all(50.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookingNotifier = context.watch<BookingNotifier>();

    // Animate camera when route is fetched
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (bookingNotifier.routePoints.isNotEmpty && widget.isFreeRoam) {
        _fitRouteBounds(bookingNotifier.routePoints);
      }
    });

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
        if (bookingNotifier.routePoints.isNotEmpty)
          PolylineLayer(
            polylines: [
              Polyline(
                points: bookingNotifier.routePoints,
                strokeWidth: 5.0,
                color: AppColors.gautrainNavy,
              ),
            ],
          ),
        MarkerLayer(
          markers: [
            Marker(
              point: bookingNotifier.origin,
              width: 60,
              height: 60,
              child: const Icon(Icons.train, color: AppColors.gautrainGold, size: 40),
            ),
            if (bookingNotifier.destination != null)
              Marker(
                point: bookingNotifier.destination!,
                width: 60,
                height: 60,
                child: bookingNotifier.isLoadingRoute
                    ? const CircularProgressIndicator(color: AppColors.gautrainNavy)
                    : const Icon(Icons.location_on, color: AppColors.gautrainNavy, size: 40),
              ),
          ],
        ),
      ],
    );
  }
}