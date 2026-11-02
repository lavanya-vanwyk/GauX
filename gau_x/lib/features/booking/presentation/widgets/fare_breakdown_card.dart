import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../state/booking_controller.dart';

/// The quoted fare. Rebuilds only when the fare changes.
class FareBreakdownCard extends ConsumerWidget {
  const FareBreakdownCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fare = ref.watch(
      bookingControllerProvider.select((s) => s.quote?.fare ?? 0),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Trip fare',
          style: TextStyle(color: Colors.grey, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'R ${fare.toStringAsFixed(2)}',
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              '• Pay from Wallet',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
