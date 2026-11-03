import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/gautrain_station.dart';
import '../state/station_controller.dart';

/// "From: Sandton" style pill. The nearest station is preselected; tapping lets
/// the rider choose another.
class StationSelectorDropdown extends ConsumerWidget {
  const StationSelectorDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selection = ref.watch(stationControllerProvider);
    final origin = ref.watch(originStationProvider);
    final stations = selection.value?.stations ?? [origin];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.deepNavy,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.train, color: AppColors.gautrainGold, size: 18),
          const SizedBox(width: 8),
          const Text(
            'From',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(width: 8),
          DropdownButtonHideUnderline(
            child: DropdownButton<GautrainStation>(
              value: origin,
              dropdownColor: AppColors.deepNavy,
              iconEnabledColor: AppColors.gautrainGold,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
              items: [
                for (final station in stations)
                  DropdownMenuItem(value: station, child: Text(station.name)),
              ],
              onChanged: selection.hasValue
                  ? (station) {
                      if (station == null) return;
                      ref
                          .read(stationControllerProvider.notifier)
                          .select(station);
                    }
                  : null,
            ),
          ),
          if (selection.value?.source == StationSource.nearest)
            const Tooltip(
              message: 'Nearest station to you',
              child: Icon(Icons.near_me, color: Colors.grey, size: 14),
            ),
          if (selection.isLoading)
            const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.gautrainGold,
              ),
            ),
        ],
      ),
    );
  }
}
