import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/remote_config/remote_config_providers.dart';
import '../../../booking/presentation/state/booking_controller.dart';
import '../../../booking/presentation/widgets/booking_quote_panel.dart';
import '../state/ride_controller.dart';
import 'ride_status_panel.dart';

/// The panel at the bottom of the ride screen: the quote before the ride,
/// the ride status during it. Hidden until a route is loaded.
class RideBottomSheet extends ConsumerWidget {
  const RideBottomSheet({super.key});

  Future<void> _confirmRide(BuildContext context, WidgetRef ref) async {
    final booking = ref.read(bookingControllerProvider);
    final quote = booking.quote;
    if (quote == null) return;

    final messenger = ScaffoldMessenger.of(context);
    final result = await ref
        .read(rideControllerProvider.notifier)
        .startRide(quote, booking.routePoints);

    if (result == StartRideResult.insufficientFunds) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Insufficient funds. Please top up your Wallet.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasRoute = ref.watch(
      bookingControllerProvider.select((s) => s.routePoints.isNotEmpty),
    );
    final isIdle = ref.watch(rideControllerProvider.select((s) => s.isIdle));
    final flags = ref.watch(featureFlagsProvider);
    if (!hasRoute) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.fromLTRB(
        24,
        24,
        24,
        24 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: const BoxDecoration(
        color: AppColors.deepNavy,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: isIdle
          ? BookingQuotePanel(
              onConfirm: flags.bookingEnabled
                  ? () => unawaited(_confirmRide(context, ref))
                  : null,
              disabledMessage: flags.bookingDisabledMessage.isNotEmpty
                  ? flags.bookingDisabledMessage
                  : 'Booking is paused right now. Please try again later.',
            )
          : const RideStatusPanel(),
    );
  }
}
