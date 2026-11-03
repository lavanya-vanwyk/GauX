import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../booking/presentation/state/booking_controller.dart';
import '../../../booking/presentation/state/station_controller.dart';
import '../state/ride_controller.dart';

/// OSM tiles, colour-inverted to suit the dark UI.
class DarkTileLayer extends StatelessWidget {
  const DarkTileLayer({super.key});

  static const _invert = ColorFilter.matrix(<double>[
    -1, 0, 0, 0, 255, //
    0, -1, 0, 0, 255, //
    0, 0, -1, 0, 255, //
    0, 0, 0, 1, 0, //
  ]);

  @override
  Widget build(BuildContext context) {
    return TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'com.example.gaux',
      tileBuilder: (context, tileWidget, tile) =>
          ColorFiltered(colorFilter: _invert, child: tileWidget),
    );
  }
}

class RoutePolylineLayer extends ConsumerWidget {
  const RoutePolylineLayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final points = ref.watch(
      bookingControllerProvider.select((s) => s.routePoints),
    );
    if (points.isEmpty) return const SizedBox.shrink();
    return PolylineLayer(
      polylines: [
        Polyline(
          points: points,
          strokeWidth: 5.0,
          color: AppColors.gautrainGold,
        ),
      ],
    );
  }
}

/// The origin station, and the destination pin (or where it's being
/// dragged to).
class StationAndDestinationLayer extends ConsumerWidget {
  const StationAndDestinationLayer({super.key, this.draggedPosition});

  final LatLng? draggedPosition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final origin = ref.watch(originStationProvider);
    final destination = ref.watch(
      bookingControllerProvider.select((s) => s.destination),
    );
    final isLoadingRoute = ref.watch(
      bookingControllerProvider.select((s) => s.isLoadingRoute),
    );
    final isDragging = draggedPosition != null;
    final pin = draggedPosition ?? destination;

    return MarkerLayer(
      markers: [
        Marker(
          point: origin.location,
          width: 60,
          height: 60,
          child: const Icon(
            Icons.train,
            color: AppColors.gautrainGold,
            size: 40,
          ),
        ),
        if (pin != null)
          Marker(
            point: pin,
            width: 60,
            height: 60,
            child: isLoadingRoute
                ? const CircularProgressIndicator(color: AppColors.gautrainGold)
                : Icon(
                    Icons.location_on,
                    color: isDragging
                        ? AppColors.gautrainGold.withValues(alpha: 0.6)
                        : AppColors.gautrainGold,
                    size: isDragging ? 50 : 40,
                  ),
          ),
      ],
    );
  }
}

/// The driver's car. The only layer that rebuilds on each position update.
class DriverMarkerLayer extends ConsumerWidget {
  const DriverMarkerLayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final driver = ref.watch(rideControllerProvider.select((s) => s.driver));
    if (driver == null) return const SizedBox.shrink();
    return MarkerLayer(
      markers: [
        Marker(
          point: driver.position,
          width: 60,
          height: 60,
          child: Transform.rotate(
            angle: driver.heading * math.pi / 180,
            child: Image.asset(AppAssets.carMarker),
          ),
        ),
      ],
    );
  }
}
