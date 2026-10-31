import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../trip_tracking/presentation/views/active_ride_map_view.dart';
import '../state/wallet_notifier.dart';
import '../widgets/gold_card_widget.dart';

class WalletDashboardView extends StatelessWidget {
  const WalletDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.gautrainNavy,
        title: const Text('GauX',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle,
                color: AppColors.gautrainGold, size: 32),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Consumer<WalletNotifier>(
        builder: (context, wallet, child) {
          if (wallet.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.gautrainGold),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              GoldCardWidget(balance: wallet.balance),
              const SizedBox(height: 24),

              // Action Buttons Row (3 items, evenly spaced)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildQuickAction(
                    icon: Icons.account_balance_wallet,
                    label: 'Top Up',
                    onTap: () => _showTopUpSheet(context),
                  ),
                  _buildQuickAction(
                    icon: Icons.calendar_today,
                    label: 'Timetable',
                    onTap: () {},
                  ),
                  _buildQuickAction(
                    icon: Icons.headset_mic,
                    label: 'Help',
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 32),

              const Text(
                'Recent Trips',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.gautrainNavy,
                ),
              ),
              const SizedBox(height: 16),

              // Styled Trip Cards
              ...wallet.recentTrips.map(
                (trip) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2)),
                    ],
                  ),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: AppColors.lightGrey,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.directions_transit,
                          color: AppColors.gautrainNavy),
                    ),
                    title: Text(
                      trip['route'] as String,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.gautrainNavy),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(trip['date'] as String,
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 12)),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          // If cost is negative, it's a deduction (red). If positive, it's a top-up (green).
                          (trip['cost'] as num) < 0
                              ? 'R ${((trip['cost'] as num).toDouble() * -1).toStringAsFixed(2)}'
                              : '+R ${(trip['cost'] as num).toDouble().toStringAsFixed(2)}',
                          style: TextStyle(
                            color: (trip['cost'] as num) < 0
                                ? Colors.redAccent
                                : Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.chevron_right, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                    builder: (_) => const ActiveRideMapView()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gautrainGold,
              foregroundColor: AppColors.deepNavy,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: const Text('Request GauX Ride',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAction(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
              ],
            ),
            child: Icon(icon, color: AppColors.gautrainNavy, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
                color: AppColors.gautrainNavy,
                fontSize: 12,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  void _showTopUpSheet(BuildContext context) {
    unawaited(showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Top Up GauX Wallet',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.gautrainNavy),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              _buildTopUpOption(
                context: sheetContext,
                icon: Icons.phone_android,
                title: 'FNB eWallet',
                subtitle: 'Instant transfer via USSD or App',
                onTap: () {
                  unawaited(
                    context
                        .read<WalletNotifier>()
                        .topUpWallet(100.0, 'FNB eWallet'),
                  );
                  Navigator.pop(sheetContext);
                },
              ),
              const SizedBox(height: 12),
              _buildTopUpOption(
                context: sheetContext,
                icon: Icons.account_balance,
                title: 'Instant EFT',
                subtitle: 'Ozow / Stitch secure payment',
                onTap: () {
                  unawaited(
                    context
                        .read<WalletNotifier>()
                        .topUpWallet(150.0, 'Instant EFT'),
                  );
                  Navigator.pop(sheetContext);
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    ));
  }

  Widget _buildTopUpOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.lightGrey, width: 2),
      ),
      leading: Icon(icon, color: AppColors.gautrainGold, size: 32),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}
