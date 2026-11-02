import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/routing/app_routes.dart';

class TripCompletedDialog extends StatelessWidget {
  const TripCompletedDialog({super.key, required this.fareAmount});

  final double fareAmount;

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
        'Fare of R ${fareAmount.toStringAsFixed(2)} successfully deducted from '
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
