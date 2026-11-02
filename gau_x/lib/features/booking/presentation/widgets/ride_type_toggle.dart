import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/domain/ride_type.dart';
import '../state/booking_controller.dart';

/// Private / Pool switch at the top of the quote panel.
class RideTypeToggle extends ConsumerWidget {
  const RideTypeToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(
      bookingControllerProvider.select((s) => s.rideType),
    );

    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.gautrainNavy,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          for (final type in RideType.values)
            _Option(
              title: type.displayName,
              isSelected: type == selected,
              onTap: () => ref
                  .read(bookingControllerProvider.notifier)
                  .setRideType(type),
            ),
        ],
      ),
    );
  }
}

class _Option extends StatelessWidget {
  const _Option({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: isSelected
                ? Border.all(color: AppColors.gautrainGold, width: 1.5)
                : null,
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? AppColors.white : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
