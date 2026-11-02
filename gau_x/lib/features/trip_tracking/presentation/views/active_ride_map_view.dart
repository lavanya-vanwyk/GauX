import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../booking/presentation/state/booking_controller.dart';
import '../../../booking/presentation/widgets/address_search_bar.dart';
import '../../../booking/presentation/widgets/station_selector_dropdown.dart';
import '../state/ride_controller.dart';
import '../state/ride_state.dart';
import '../widgets/live_map_canvas.dart';
import '../widgets/ride_bottom_sheet.dart';
import '../widgets/trip_completed_dialog.dart';

/// Book and follow a GauX ride.
class ActiveRideMapView extends ConsumerWidget {
  const ActiveRideMapView({super.key});

  void _onArrived(BuildContext context, WidgetRef ref, RideArrived ride) {
    final dialog = showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => TripCompletedDialog(fareAmount: ride.quote.fare),
    );
    unawaited(
      dialog.then((_) {
        // The fare was charged on arrival; start fresh for the next ride
        ref.read(rideControllerProvider.notifier).reset();
        ref.read(bookingControllerProvider.notifier).clearDestination();
      }),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(rideControllerProvider, (previous, next) {
      if (next is RideArrived && previous is! RideArrived) {
        _onArrived(context, ref, next);
      }
    });
    final isIdle = ref.watch(rideControllerProvider.select((s) => s.isIdle));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Request GauX Ride',
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.deepNavy,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          // Opened from a deep link there is nothing to pop back to
          onPressed: () =>
              context.canPop() ? context.pop() : context.go(AppRoutes.wallet),
        ),
      ),
      body: Stack(
        children: [
          const LiveMapCanvas(),
          if (isIdle)
            const Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StationSelectorDropdown(),
                  SizedBox(height: 12),
                  AddressSearchBar(),
                ],
              ),
            ),
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: RideBottomSheet(),
          ),
        ],
      ),
    );
  }
}
