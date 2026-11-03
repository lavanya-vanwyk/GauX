import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../booking/presentation/state/booking_controller.dart';
import '../../../booking/presentation/state/station_controller.dart';
import '../../../booking/presentation/widgets/booking_feedback.dart';
import '../state/ride_controller.dart';
import 'map_layers.dart';

/// The ride map. Before a ride, tapping or dragging the map sets the
/// destination.
class LiveMapCanvas extends ConsumerStatefulWidget {
  const LiveMapCanvas({super.key});

  @override
  ConsumerState<LiveMapCanvas> createState() => _LiveMapCanvasState();
}

class _LiveMapCanvasState extends ConsumerState<LiveMapCanvas> {
  final _mapController = MapController();
  LatLng? _draggedPosition;

  bool get _canEditDestination => ref.read(rideControllerProvider).isIdle;

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _fitRoute(List<LatLng> points) {
    if (points.length < 2) return;
    final bounds = LatLngBounds.fromPoints(points);
    // Start and end at the same spot would make the zoom infinite
    if (bounds.northWest == bounds.southEast) return;
    _mapController.fitCamera(
      CameraFit.bounds(
        bounds: bounds,
        padding: const EdgeInsets.all(50.0),
        maxZoom: 18.0, // Avoids NaN zoom on very short routes
      ),
    );
  }

  Future<void> _setDestination(LatLng point) async {
    final result = await ref
        .read(bookingControllerProvider.notifier)
        .setDestination(point);
    if (mounted) showBookingFeedback(context, result);
  }

  @override
  Widget build(BuildContext context) {
    // Frame each new route, and recentre when the origin station changes
    ref.listen(bookingControllerProvider.select((s) => s.routePoints), (
      _,
      points,
    ) {
      if (_canEditDestination) _fitRoute(points);
    });
    ref.listen(originStationProvider, (_, station) {
      _mapController.move(station.location, 16.0);
    });

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        backgroundColor: AppColors.deepNavy,
        initialCenter: ref.read(originStationProvider).location,
        initialZoom: 16.0,
        onTap: (_, point) {
          if (_canEditDestination) unawaited(_setDestination(point));
        },
        // Drag the map to move the destination pin
        onPositionChanged: (camera, hasGesture) {
          if (hasGesture && _canEditDestination) {
            setState(() => _draggedPosition = camera.center);
          }
        },
        onMapEvent: (event) {
          final dropped = _draggedPosition;
          if (event is MapEventMoveEnd && dropped != null) {
            setState(() => _draggedPosition = null);
            unawaited(_setDestination(dropped));
          }
        },
      ),
      children: [
        const DarkTileLayer(),
        const RoutePolylineLayer(),
        StationAndDestinationLayer(draggedPosition: _draggedPosition),
        const DriverMarkerLayer(),
      ],
    );
  }
}
