import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/remote_config/remote_config_providers.dart';
import '../state/booking_controller.dart';

/// Tells the rider why a destination wasn't accepted. Does nothing on
/// success.
void showBookingFeedback(BuildContext context, BookingResult result) {
  switch (result) {
    case BookingResult.success:
      return;
    case BookingResult.outsideGeofence:
      unawaited(
        showDialog<void>(
          context: context,
          builder: (_) => const _OutsideServiceAreaDialog(),
        ),
      );
    case BookingResult.notFound:
      _showError(context, 'Could not find that address. Please try again.');
    case BookingResult.routeUnavailable:
      _showError(
        context,
        "Couldn't load a route. Check your connection and try again.",
      );
  }
}

void _showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
  );
}

class _OutsideServiceAreaDialog extends ConsumerWidget {
  const _OutsideServiceAreaDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radiusKm =
        ref.watch(
          remoteConfigControllerProvider.select(
            (c) => c.serviceArea.radiusMeters,
          ),
        ) /
        1000;
    return AlertDialog(
      backgroundColor: AppColors.deepNavy,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Row(
        children: [
          Icon(Icons.security, color: AppColors.gautrainGold),
          SizedBox(width: 12),
          // Expanded prevents the title overflowing on narrow screens
          Expanded(
            child: Text(
              'Outside Service Area',
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ],
      ),
      content: Text(
        'To ensure fast pickups and maintain our micro-fleet efficiency, GauX '
        'vehicles are geo-fenced to a ${_km(radiusKm)} radius around the '
        'station.\n\nPlease select a destination closer to the station.',
        style: const TextStyle(color: Colors.grey, height: 1.4),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Understood',
            style: TextStyle(color: AppColors.gautrainGold),
          ),
        ),
      ],
    );
  }
}

/// "5km", "2.5km"
String _km(double km) =>
    '${km == km.roundToDouble() ? km.toStringAsFixed(0) : km.toStringAsFixed(1)}km';
