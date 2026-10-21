import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/map_viewport_notifier.dart';
import '../state/simulation_controller.dart';
import '../widgets/live_map_canvas.dart';
import '../widgets/trip_completed_dialog.dart';
import '../../../booking/presentation/views/booking_sheet_view.dart';
import '../../../booking/presentation/state/booking_notifier.dart';
import '../../../wallet/presentation/state/wallet_notifier.dart';

class ActiveRideMapView extends StatefulWidget {
  const ActiveRideMapView({super.key});

  @override
  State<ActiveRideMapView> createState() => _ActiveRideMapViewState();
}

class _ActiveRideMapViewState extends State<ActiveRideMapView> {
  SimulationController? _simController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MapViewportNotifier>().initializePermissions();
    });

    _simController = context.read<SimulationController>();
    _simController?.addListener(_onSimulationStateChanged);
  }

  @override
  void dispose() {
    _simController?.removeListener(_onSimulationStateChanged);
    super.dispose();
  }

  void _onSimulationStateChanged() {
    if (!mounted) return;

    if (_simController?.rideState == RideState.arrived) {
      final bookingNotifier = context.read<BookingNotifier>();
      final walletNotifier = context.read<WalletNotifier>();

      walletNotifier.processRidePayment(bookingNotifier.fareAmount);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => TripCompletedDialog(fareAmount: bookingNotifier.fareAmount),
      ).then((_) {
        _simController?.stopSimulation();
        bookingNotifier.clearDestination();
      });
    }
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
          return Stack(
            children: [
              const LiveMapCanvas(),
              const Positioned(
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