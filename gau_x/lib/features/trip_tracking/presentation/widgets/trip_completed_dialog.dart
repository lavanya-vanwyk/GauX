import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class TripCompletedDialog extends StatelessWidget {
  final double fareAmount;

  const TripCompletedDialog({super.key, required this.fareAmount});

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
        'Fare of R ${fareAmount.toStringAsFixed(2)} successfully deducted from your Gold Card.',
        style: const TextStyle(fontSize: 16),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close Dialog
            Navigator.of(context).pop(); // Exit Map View
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
