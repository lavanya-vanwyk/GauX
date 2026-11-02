import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/utils/currency_formatter.dart';

class TripCompletedDialog extends StatelessWidget {
  const TripCompletedDialog({
    super.key,
    required this.fareCents,
    this.paymentFailed = false,
  });

  final int fareCents;

  /// The fare couldn't be charged (e.g. offline at arrival).
  final bool paymentFailed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'You have arrived!',
        style: TextStyle(
          color: AppColors.gautrainNavy,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        paymentFailed
            ? "We couldn't charge the ${formatRand(fareCents)} fare just now. "
                  "It's still owed; check your wallet once you're back "
                  'online.'
            : 'Fare of ${formatRand(fareCents)} successfully deducted from '
                  'your Gold Card.',
        style: const TextStyle(fontSize: 16),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            final router = GoRouter.of(context);
            Navigator.of(context).pop();
            router.go(AppRoutes.wallet);
          },
          child: const Text(
            'Back to Wallet',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
