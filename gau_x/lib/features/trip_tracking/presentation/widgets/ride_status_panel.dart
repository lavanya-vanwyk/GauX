import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/remote_config/remote_config_providers.dart';
import '../state/ride_controller.dart';
import '../state/ride_state.dart';
import 'cancel_ride_button.dart';
import 'sos_button.dart';

/// Status of an active ride, with cancel and SOS. Rebuilds on phase
/// changes only, not on every driver position update.
class RideStatusPanel extends ConsumerWidget {
  const RideStatusPanel({super.key});

  static String _statusText(RidePhase phase) => switch (phase) {
    RidePhase.matching => 'Matching with other commuters...',
    RidePhase.searching => 'Searching for driver...',
    RidePhase.arriving => 'Driver is arriving!',
    RidePhase.inTransit => 'Heading to destination...',
    RidePhase.arrived => 'You have arrived!',
    RidePhase.idle => '',
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phase = ref.watch(rideControllerProvider.select((s) => s.phase));
    final sosEnabled = ref.watch(
      featureFlagsProvider.select((f) => f.sosEnabled),
    );

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          children: [
            if (phase case RidePhase.searching || RidePhase.matching)
              const CircularProgressIndicator(color: AppColors.gautrainGold),
            const SizedBox(height: 24),
            Text(
              _statusText(phase),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 32),
            if (phase != RidePhase.arrived)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CancelRideButton(),
                  if (sosEnabled) ...[
                    const SizedBox(width: 16),
                    const SosButton(),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }
}
