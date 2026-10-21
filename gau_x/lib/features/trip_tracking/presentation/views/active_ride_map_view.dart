import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/map_viewport_notifier.dart';
import '../widgets/live_map_canvas.dart';
import '../../booking/presentation/views/booking_sheet_view.dart';

class ActiveRideMapView extends StatefulWidget {
  const ActiveRideMapView({super.key});

  @override
  State<ActiveRideMapView> createState() => _ActiveRideMapViewState();
}

class _ActiveRideMapViewState extends State<ActiveRideMapView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MapViewportNotifier>().initializePermissions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Last-Mile Ride')),
      body: Consumer<MapViewportNotifier>(
        builder: (context, viewportNotifier, child) {
          if (!viewportNotifier.hasLocationPermission) {
            return const Center(
              child: Text('Location permission is required to book a ride.'),
            );
          }
          return const Stack(
            children: [
              LiveMapCanvas(),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: BookingSheetView(),
              ),
            ],
          );
        },
      ),
    );
  }
}