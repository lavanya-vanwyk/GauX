import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../di/wallet_providers.dart';

/// Bottom sheet with the (simulated) top-up methods.
class TopUpSheet extends ConsumerWidget {
  const TopUpSheet({super.key});

  static Future<void> show(BuildContext context) => showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) => const TopUpSheet(),
  );

  void _topUp(
    BuildContext context,
    WidgetRef ref,
    double amount,
    String method,
  ) {
    unawaited(
      ref.read(topUpWalletProvider)(amount: amount, paymentMethod: method),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              color: AppColors.gautrainNavy,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          _TopUpOption(
            icon: Icons.phone_android,
            title: 'FNB eWallet',
            subtitle: 'Instant transfer via USSD or App',
            onTap: () => _topUp(context, ref, 100.0, 'FNB eWallet'),
          ),
          const SizedBox(height: 12),
          _TopUpOption(
            icon: Icons.account_balance,
            title: 'Instant EFT',
            subtitle: 'Ozow / Stitch secure payment',
            onTap: () => _topUp(context, ref, 150.0, 'Instant EFT'),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _TopUpOption extends StatelessWidget {
  const _TopUpOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
