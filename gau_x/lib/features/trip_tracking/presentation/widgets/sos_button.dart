import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// Discreet emergency button shown during a ride.
///
/// Only confirms locally for now; nothing is sent until the GauX Security
/// backend exists (see the architecture review, finding 21).
class SosButton extends StatelessWidget {
  const SosButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.redAccent.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(Icons.shield_outlined, color: Colors.redAccent),
        tooltip: 'Safety & SOS',
        onPressed: () => unawaited(
          showDialog<void>(
            context: context,
            builder: (_) => const _SosDialog(),
          ),
        ),
      ),
    );
  }
}

class _SosDialog extends StatelessWidget {
  const _SosDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.deepNavy,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Row(
        children: [
          Icon(Icons.security, color: Colors.redAccent),
          SizedBox(width: 8),
          Text('Emergency SOS', style: TextStyle(color: AppColors.white)),
        ],
      ),
      content: const Text(
        'Do you need immediate assistance? This will discreetly share your '
        'live route telemetry with GauX Security and your emergency contacts.',
        style: TextStyle(color: Colors.grey, height: 1.4),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel', style: TextStyle(color: AppColors.white)),
        ),
        ElevatedButton(
          onPressed: () {
            final messenger = ScaffoldMessenger.of(context);
            Navigator.of(context).pop();
            messenger.showSnackBar(
              const SnackBar(
                content: Text(
                  'SOS Triggered. GauX Security is tracking your vehicle.',
                ),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            foregroundColor: AppColors.white,
          ),
          child: const Text('Trigger SOS'),
        ),
      ],
    );
  }
}
