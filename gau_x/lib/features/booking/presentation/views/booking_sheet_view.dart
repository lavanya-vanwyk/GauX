import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../state/booking_notifier.dart';
import '../../../trip_tracking/presentation/state/simulation_controller.dart';
import '../../../wallet/presentation/state/wallet_notifier.dart';

class BookingSheetView extends StatelessWidget {
  const BookingSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<BookingNotifier, SimulationController, WalletNotifier>(
      builder: (context, bookingNotifier, simulationController, walletNotifier, child) {
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
                
                // Segmented Toggle for Ride Type
                SegmentedButton<RideType>(
                  segments: const [
                    ButtonSegment(value: RideType.private, label: Text('GauX Private')),
                    ButtonSegment(value: RideType.pool, label: Text('GauX Pool')),
                  ],
                  selected: {bookingNotifier.selectedRideType},
                  onSelectionChanged: (Set<RideType> newSelection) {
                    bookingNotifier.setRideType(newSelection.first);
                  },
                  style: SegmentedButton.styleFrom(
                    selectedBackgroundColor: AppColors.gautrainGold.withOpacity(0.2),
                    selectedForegroundColor: AppColors.gautrainNavy,
                  ),
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
                
                Text(
                  'R ${bookingNotifier.fareAmount.toStringAsFixed(2)} to be deducted from Gold Card: **** 1234',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.gautrainGold, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 24),
                
                ElevatedButton(
                  onPressed: () {
                    // Ticket 5.4: Validate wallet balance before starting simulation
                    if (walletNotifier.canAffordRide(bookingNotifier.fareAmount)) {
                      simulationController.startSimulation(
                        bookingNotifier.routePoints, 
                        bookingNotifier.selectedRideType,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Insufficient funds. Please top up your Gold Card.'),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
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
                        if (simulationController.rideState == RideState.searching || 
                            simulationController.rideState == RideState.matching)
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
      case RideState.matching:
        return 'Matching with other commuters...';
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