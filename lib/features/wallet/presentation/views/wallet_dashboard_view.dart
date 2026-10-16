import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/wallet_notifier.dart';
import '../widgets/gold_card_widget.dart';
import '../../trip_tracking/presentation/views/active_ride_map_view.dart';
import '../../../core/constants/app_colors.dart';

class WalletDashboardView extends StatelessWidget {
  const WalletDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wallet'),
      ),
      body: Consumer<WalletNotifier>(
        builder: (context, wallet, child) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              GoldCardWidget(balance: wallet.balance),
              const SizedBox(height: 32),
              const Text(
                'Recent Trips', 
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                  color: AppColors.gautrainNavy,
                ),
              ),
              const SizedBox(height: 16),
              ...wallet.recentTrips.map((trip) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: AppColors.lightGrey,
                  child: const Icon(Icons.directions_transit, color: AppColors.gautrainNavy),
                ),
                title: Text(trip['route'] as String, style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(trip['date'] as String),
                trailing: Text(
                  'R ${((trip['cost'] as double) * -1).toStringAsFixed(2)}', 
                  style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              )),
            ],
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (_) => const ActiveRideMapView()),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Book Last-Mile Ride', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
