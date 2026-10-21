import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../state/booking_notifier.dart';
import '../../../trip_tracking/presentation/state/simulation_controller.dart';

class BookingSheetView extends StatelessWidget {
  const BookingSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<BookingNotifier, SimulationController>(
      builder: (context, bookingNotifier, simulationController, child) {
        if (bookingNotifier.routePoints.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (simulationController.rideState == RideState.initial) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Estimated Time: ${bookingNotifier.estimatedTimeMins} mins',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      '${bookingNotifier.distanceKm.toStringAsFixed(1)} km',
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Fare', style: TextStyle(fontSize: 16)),
                      Text(
                        'R ${bookingNotifier.fareAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.gautrainNavy,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'To be deducted from Gold Card: **** 1234',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.gautrainGold, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    context.read<SimulationController>().startSimulation(bookingNotifier.routePoints);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Confirm Ride', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ] else ...[
                // Dynamic active ride states
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      children: [
                        if (simulationController.rideState == RideState.searching)
                          const CircularProgressIndicator(color: AppColors.gautrainGold),
                        const SizedBox(height: 16),
                        Text(
                          _getStatusText(simulationController.rideState),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.gautrainNavy,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]
            ],
          ),
        );
      },
    );
  }

  String _getStatusText(RideState state) {
    switch (state) {
      case RideState.searching:
        return 'Searching for driver...';
      case RideState.arriving:
        return 'Driver is arriving!';
      case RideState.inTransit:
        return 'Heading to destination...';
      case RideState.arrived:
        return 'You have arrived!';
      default:
        return '';
    }
  }
}