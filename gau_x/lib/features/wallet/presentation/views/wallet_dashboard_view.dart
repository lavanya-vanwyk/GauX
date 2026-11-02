import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/routing/app_routes.dart';
import '../../di/wallet_providers.dart';
import '../widgets/gold_card_widget.dart';
import '../widgets/quick_actions_row.dart';
import '../widgets/top_up_sheet.dart';
import '../widgets/trip_history_tile.dart';

class WalletDashboardView extends ConsumerWidget {
  const WalletDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final card = ref.watch(goldCardProvider);

    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: AppBar(
        backgroundColor: AppColors.gautrainNavy,
        title: const Text(
          'GauX',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.account_circle,
              color: AppColors.gautrainGold,
              size: 32,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: switch (card) {
        AsyncData(:final value) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            GoldCardWidget(balance: value.balance),
            const SizedBox(height: 24),
            QuickActionsRow(onTopUp: () => unawaited(TopUpSheet.show(context))),
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
            for (final entry in value.ledger) TripHistoryTile(entry: entry),
          ],
        ),
        AsyncError(:final error) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              "Couldn't load your wallet. Restart the app to try again.\n\n"
              '$error',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        _ => const Center(
          child: CircularProgressIndicator(color: AppColors.gautrainGold),
        ),
      },
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ElevatedButton(
            onPressed: () => unawaited(context.push(AppRoutes.ride)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.gautrainGold,
              foregroundColor: AppColors.deepNavy,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: const Text(
              'Request GauX Ride',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
