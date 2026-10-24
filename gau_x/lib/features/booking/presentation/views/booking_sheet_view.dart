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
            color: AppColors.deepNavy,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, -2))],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (simulationController.rideState == RideState.initial) ...[
                // Custom Private/Pool Toggle
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.gautrainNavy,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      _buildToggleOption(
                        context: context,
                        title: 'GauX Private',
                        isSelected: bookingNotifier.selectedRideType == RideType.private,
                        onTap: () => bookingNotifier.setRideType(RideType.private),
                      ),
                      _buildToggleOption(
                        context: context,
                        title: 'GauX Pool',
                        isSelected: bookingNotifier.selectedRideType == RideType.pool,
                        onTap: () => bookingNotifier.setRideType(RideType.pool),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Vehicle Info
                Row(
                  children: [
                    const Icon(Icons.directions_car, color: AppColors.gautrainGold, size: 60), 
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bookingNotifier.selectedRideType == RideType.private ? 'GauX Private' : 'GauX Pool',
                          style: const TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '4 seats • 2 min away',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Arrives in 2 min',
                          style: TextStyle(color: AppColors.gautrainGold, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Divider(color: Colors.white24),
                const SizedBox(height: 16),

                // Fare & Payment Method
                const Text('Trip fare', style: TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      'R ${bookingNotifier.fareAmount.toStringAsFixed(2)}',
                      style: const TextStyle(color: AppColors.white, fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    const Text('• Pay from Wallet', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Colors.white24),
                const SizedBox(height: 16),

                // Payment Method Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.account_balance_wallet, color: AppColors.gautrainGold),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Payment method', style: TextStyle(color: Colors.grey, fontSize: 12)),
                            Text('GauX Digital Wallet', style: TextStyle(color: AppColors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
                const SizedBox(height: 32),

                // Buttons
                ElevatedButton(
                  onPressed: () {
                    if (walletNotifier.canAffordRide(bookingNotifier.fareAmount)) {
                      simulationController.startSimulation(
                        bookingNotifier.routePoints, 
                        bookingNotifier.selectedRideType,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Insufficient funds. Please top up your Wallet.'),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.gautrainGold,
                    foregroundColor: AppColors.deepNavy,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                  child: const Text('Confirm Ride', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () => bookingNotifier.clearDestination(),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.gautrainGold),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                  child: const Text('Cancel', style: TextStyle(color: AppColors.white, fontSize: 16)),
                ),
              ] else ...[
                // Dynamic active ride states (Searching, Matching, etc.)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Column(
                      children: [
                        if (simulationController.rideState == RideState.searching || 
                            simulationController.rideState == RideState.matching)
                          const CircularProgressIndicator(color: AppColors.gautrainGold),
                        const SizedBox(height: 24),
                        Text(
                          _getStatusText(simulationController.rideState),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 32),
                        
                        // New In-Progress Cancel Button
                        OutlinedButton(
                          onPressed: () {
                            double charge = 0.0;
                            
                            // Only charge them if the car is actually moving (inTransit)
                            if (simulationController.rideState == RideState.inTransit) {
                              double coveredMeters = simulationController.currentDriverLocation?.totalDistanceCovered ?? 0.0;
                              charge = bookingNotifier.calculatePartialFare(coveredMeters);
                            }
                            
                            // Process partial payment if applicable
                            if (charge > 0) {
                              walletNotifier.processRidePayment(
                                charge, 
                                bookingNotifier.selectedRideType, 
                                isCanceled: true
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Ride canceled. Partial fare of R ${charge.toStringAsFixed(2)} charged.'),
                                  backgroundColor: AppColors.gautrainNavy,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Ride canceled. No charge applied.'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                            
                            // Kill the simulation and clear the map
                            simulationController.stopSimulation();
                            bookingNotifier.clearDestination();
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.redAccent),
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          ),
                          child: const Text('Cancel Ride', style: TextStyle(color: Colors.redAccent, fontSize: 16)),
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

  Widget _buildToggleOption({
    required BuildContext context,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.transparent : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: isSelected ? Border.all(color: AppColors.gautrainGold, width: 1.5) : null,
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? AppColors.white : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
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