import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/domain/result.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../../booking/presentation/state/booking_controller.dart';
import '../state/ride_controller.dart';

/// Cancels the active ride after the rider confirms the fee.
class CancelRideButton extends ConsumerWidget {
  const CancelRideButton({super.key});

  Future<void> _confirm(BuildContext context, WidgetRef ref) async {
    // Fixed when the dialog opens, so the rider is charged what they saw
    final terms = ref.read(rideControllerProvider.notifier).cancellationTerms;
    if (terms == null) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => _CancelRideDialog(feeCents: terms.feeCents),
    );
    if (confirmed != true || !context.mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    final charged = await ref
        .read(rideControllerProvider.notifier)
        .cancelRide(terms);
    ref.read(bookingControllerProvider.notifier).clearDestination();

    messenger.showSnackBar(switch (charged) {
      Success(value: > 0 && final cents) => SnackBar(
        content: Text(
          'Ride canceled. Partial fare of ${formatRand(cents)} charged.',
        ),
        backgroundColor: AppColors.gautrainNavy,
      ),
      Success() => const SnackBar(
        content: Text('Ride canceled. No charge applied.'),
        backgroundColor: Colors.green,
      ),
      Err() => const SnackBar(
        content: Text(
          "Ride canceled, but we couldn't confirm the cancellation fee. "
          'Check your wallet once you are back online.',
        ),
        backgroundColor: Colors.redAccent,
      ),
    });
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
  const _CancelRideDialog({required this.feeCents});

  final int feeCents;

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
        feeCents > 0
            ? 'Are you sure you want to cancel? You will be charged a partial '
                  'fare of ${formatRand(feeCents)} for the distance '
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
