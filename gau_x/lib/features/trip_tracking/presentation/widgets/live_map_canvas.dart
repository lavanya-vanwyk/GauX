import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../booking/presentation/state/booking_notifier.dart';
import '../state/simulation_controller.dart';

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
    if (routePoints.length < 2) return; // Prevent bounds calculation on single points

    final bounds = LatLngBounds.fromPoints(routePoints);

    // Prevent infinity error if bounds are too tight (start and end are practically the same)
    if (bounds.northWest == bounds.southEast) return;

    _mapController.fitCamera(
      CameraFit.bounds(
        bounds: bounds,
        padding: const EdgeInsets.all(50.0),
        maxZoom: 18.0, // Cap the zoom to prevent NaN/Infinity calculation errors
      ),
    );
  }
  void _showGeofenceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.deepNavy,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.security, color: AppColors.gautrainGold),
              SizedBox(width: 12),
              // Wrapping the Text in an Expanded widget prevents the pixel overflow
              Expanded(
                child: Text(
                  'Outside Service Area', 
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ],
          ),
          content: const Text(
            'To ensure fast pickups and maintain our micro-fleet efficiency, GauX vehicles are geo-fenced to a 5km radius around the station.\n\nPlease select a destination closer to the station.',
            style: TextStyle(color: Colors.grey, height: 1.4),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Understood', style: TextStyle(color: AppColors.gautrainGold)),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookingNotifier = context.watch<BookingNotifier>();
    final simulationController = context.watch<SimulationController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (bookingNotifier.routePoints.isNotEmpty && widget.isFreeRoam && !simulationController.isSimulating) {
        _fitRouteBounds(bookingNotifier.routePoints);
      }
    });

    // Ensure 'return Container(' is included here:
    return Container(
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          backgroundColor: AppColors.deepNavy,
          initialCenter: bookingNotifier.origin,
          initialZoom: 16.0,
          onTap: (tapPosition, point) async {
              // Prevent dropping pins while a ride is active
              if (simulationController.rideState != RideState.initial) return;
              
              // Wait for the calculation result
              final result = await bookingNotifier.setDestination(point);
              
              // Show the dialog if the user taps outside the 5km radius
              if (mounted && result == BookingResult.outsideGeofence) {
                _showGeofenceDialog(context);
              }
            },
          ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.gaux',
            tileBuilder: (context, tileWidget, tile) {
              return ColorFiltered(
                colorFilter: const ColorFilter.matrix(<double>[
                  -1,  0,  0, 0, 255, 
                   0, -1,  0, 0, 255, 
                   0,  0, -1, 0, 255, 
                   0,  0,  0, 1,   0, 
                ]),
                child: tileWidget,
              );
            },
          ),
          if (bookingNotifier.routePoints.isNotEmpty)
            PolylineLayer(
              polylines: [
                Polyline(
                  points: bookingNotifier.routePoints,
                  strokeWidth: 5.0,
                  color: AppColors.gautrainGold, 
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
                      ? const CircularProgressIndicator(color: AppColors.gautrainGold)
                      : const Icon(Icons.location_on, color: AppColors.gautrainGold, size: 40),
                ),
              if (simulationController.currentDriverLocation != null)
                Marker(
                  point: simulationController.currentDriverLocation!.position,
                  width: 60,
                  height: 60,
                  child: Transform.rotate(
                    angle: simulationController.currentDriverLocation!.heading * (3.1415926535897932 / 180),
                    child: Image.asset(AppAssets.carMarker),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}