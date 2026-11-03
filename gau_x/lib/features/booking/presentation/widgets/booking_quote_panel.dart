import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../state/booking_controller.dart';
import 'fare_breakdown_card.dart';
import 'payment_method_row.dart';
import 'ride_type_toggle.dart';
import 'vehicle_summary.dart';

/// Ride type, vehicle, fare and payment, with confirm and cancel buttons.
///
/// What confirming does is up to the caller, so booking doesn't depend on
/// how rides are run. A null [onConfirm] disables the button and shows
/// [disabledMessage] instead.
class BookingQuotePanel extends ConsumerWidget {
  const BookingQuotePanel({
    super.key,
    required this.onConfirm,
    this.disabledMessage,
  });

  final VoidCallback? onConfirm;
  final String? disabledMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const RideTypeToggle(),
        const SizedBox(height: 24),
        const VehicleSummary(),
        const SizedBox(height: 24),
        const Divider(color: Colors.white24),
        const SizedBox(height: 16),
        const FareBreakdownCard(),
        const SizedBox(height: 16),
        const Divider(color: Colors.white24),
        const SizedBox(height: 16),
        const PaymentMethodRow(),
        const SizedBox(height: 32),
        if (onConfirm == null && disabledMessage != null) ...[
          Text(
            disabledMessage!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.gautrainGold),
          ),
          const SizedBox(height: 12),
        ],
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.gautrainGold,
            foregroundColor: AppColors.deepNavy,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: const Text(
            'Confirm Ride',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () =>
              ref.read(bookingControllerProvider.notifier).clearDestination(),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.gautrainGold),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: const Text(
            'Cancel',
            style: TextStyle(color: AppColors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
