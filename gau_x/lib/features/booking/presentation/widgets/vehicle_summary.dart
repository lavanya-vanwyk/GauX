import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../state/booking_controller.dart';

/// The vehicle the rider will get. Availability is placeholder copy until
/// fleet data exists.
class VehicleSummary extends ConsumerWidget {
  const VehicleSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rideType = ref.watch(
      bookingControllerProvider.select((s) => s.rideType),
    );

    return Row(
      children: [
        const Icon(
          Icons.directions_car,
          color: AppColors.gautrainGold,
          size: 60,
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              rideType.displayName,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              '4 seats • 2 min away',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 4),
            const Text(
              'Arrives in 2 min',
              style: TextStyle(
                color: AppColors.gautrainGold,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
