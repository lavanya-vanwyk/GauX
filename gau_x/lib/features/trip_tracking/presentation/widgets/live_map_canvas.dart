import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../booking/presentation/state/booking_notifier.dart';
import '../../../booking/presentation/widgets/booking_feedback.dart';
import '../state/simulation_controller.dart';

class LiveMapCanvas extends StatefulWidget {
  final bool isFreeRoam;
  const LiveMapCanvas({super.key, this.isFreeRoam = true});

  @override
  State<LiveMapCanvas> createState() => _LiveMapCanvasState();
}

class _LiveMapCanvasState extends State<LiveMapCanvas> {
  final MapController _mapController = MapController();
  LatLng? _draggedPosition;
  bool _isDragging = false;

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _fitRouteBounds(List<LatLng> routePoints) {
    // Prevent bounds calculation on single points
    if (routePoints.length < 2) return;

    final bounds = LatLngBounds.fromPoints(routePoints);

    // Prevent infinity error if bounds are too tight (start and end are practically the same)
    if (bounds.northWest == bounds.southEast) return;

    _mapController.fitCamera(
      CameraFit.bounds(
        bounds: bounds,
        padding: const EdgeInsets.all(50.0),
        maxZoom:
            18.0, // Cap the zoom to prevent NaN/Infinity calculation errors
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookingNotifier = context.watch<BookingNotifier>();
    final simulationController = context.watch<SimulationController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (bookingNotifier.routePoints.isNotEmpty &&
          widget.isFreeRoam &&
          !simulationController.isSimulating) {
        _fitRouteBounds(bookingNotifier.routePoints);
      }
    });

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        backgroundColor: AppColors.deepNavy,
        initialCenter: bookingNotifier.origin,
        initialZoom: 16.0,
        onTap: (tapPosition, point) async {
          // Prevent interactions while a ride is active
          if (simulationController.rideState != RideState.initial) return;

          final result = await bookingNotifier.setDestination(point);
          if (context.mounted) showBookingFeedback(context, result);
        },
        // Drag to drop functionality
        onPositionChanged: (position, hasGesture) {
          if (hasGesture &&
              simulationController.rideState == RideState.initial) {
            if (position.center != null) {
              setState(() {
                _draggedPosition = position.center;
                _isDragging = true;
              });
            }
          }
        },
        onMapEvent: (event) async {
          // Trigger the route calculation only when the map stops moving
          if (event is MapEventMoveEnd && _isDragging) {
            final finalDragPosition = _draggedPosition;

            setState(() {
              _isDragging = false;
              _draggedPosition =
                  null; // Clear local state to rely on the Notifier's locked destination
            });

            if (finalDragPosition != null) {
              final result = await bookingNotifier.setDestination(
                finalDragPosition,
              );
              if (context.mounted) showBookingFeedback(context, result);
            }
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
                -1,
                0,
                0,
                0,
                255,
                0,
                -1,
                0,
                0,
                255,
                0,
                0,
                -1,
                0,
                255,
                0,
                0,
                0,
                1,
                0,
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
              child: const Icon(
                Icons.train,
                color: AppColors.gautrainGold,
                size: 40,
              ),
            ),
            if (bookingNotifier.destination != null || _draggedPosition != null)
              Marker(
                point: _draggedPosition ?? bookingNotifier.destination!,
                width: 60,
                height: 60,
                child: bookingNotifier.isLoadingRoute
                    ? const CircularProgressIndicator(
                        color: AppColors.gautrainGold,
                      )
                    : Icon(
                        Icons.location_on,
                        color: _isDragging
                            ? AppColors.gautrainGold.withValues(alpha: 0.6)
                            : AppColors.gautrainGold,
                        size: _isDragging ? 50 : 40,
                      ),
              ),
            if (simulationController.currentDriverLocation != null)
              Marker(
                point: simulationController.currentDriverLocation!.position,
                width: 60,
                height: 60,
                child: Transform.rotate(
                  angle:
                      simulationController.currentDriverLocation!.heading *
                      (3.1415926535897932 / 180),
                  child: Image.asset(AppAssets.carMarker),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
