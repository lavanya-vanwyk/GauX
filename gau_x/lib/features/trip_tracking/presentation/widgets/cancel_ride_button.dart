import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../booking/presentation/state/booking_controller.dart';
import '../state/ride_controller.dart';

/// Cancels the active ride after the rider confirms the fee.
class CancelRideButton extends ConsumerWidget {
  const CancelRideButton({super.key});

  Future<void> _confirm(BuildContext context, WidgetRef ref) async {
    // Fixed when the dialog opens, so the rider is charged what they saw
    final fee = ref.read(rideControllerProvider.notifier).cancellationFee;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => _CancelRideDialog(fee: fee),
    );
    if (confirmed != true || !context.mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    final charged = await ref
        .read(rideControllerProvider.notifier)
        .cancelRide(fee: fee);
    ref.read(bookingControllerProvider.notifier).clearDestination();

    messenger.showSnackBar(
      charged > 0
          ? SnackBar(
              content: Text(
                'Ride canceled. Partial fare of R '
                '${charged.toStringAsFixed(2)} charged.',
              ),
              backgroundColor: AppColors.gautrainNavy,
            )
          : const SnackBar(
              content: Text('Ride canceled. No charge applied.'),
              backgroundColor: Colors.green,
            ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton(
      onPressed: () => unawaited(_confirm(context, ref)),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.redAccent),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      child: const Text(
        'Cancel Ride',
        style: TextStyle(color: Colors.redAccent, fontSize: 16),
      ),
    );
  }
}

class _CancelRideDialog extends StatelessWidget {
  const _CancelRideDialog({required this.fee});

  final double fee;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.deepNavy,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        'Cancel Ride?',
        style: TextStyle(color: AppColors.white),
      ),
      content: Text(
        fee > 0
            ? 'Are you sure you want to cancel? You will be charged a partial '
                  'fare of R ${fee.toStringAsFixed(2)} for the distance '
                  'traveled.'
            : 'Are you sure you want to cancel this ride? You will not be '
                  'charged.',
        style: const TextStyle(color: Colors.grey),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text(
            'Keep Ride',
            style: TextStyle(color: AppColors.white),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text(
            'Yes, Cancel',
            style: TextStyle(color: Colors.redAccent),
          ),
        ),
      ],
    );
  }
}
