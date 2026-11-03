import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/place_suggestion.dart';

/// One-tap shortcuts to the rider's saved places.
class QuickLocationChips extends StatelessWidget {
  const QuickLocationChips({super.key, required this.onSelected});

  final ValueChanged<PlaceSuggestion> onSelected;

  // Placeholder saved places until riders can manage their own
  static const _locations = [
    (
      icon: Icons.home,
      place: PlaceSuggestion(name: 'Home', location: LatLng(-25.7479, 28.1890)),
    ),
    (
      icon: Icons.school,
      place: PlaceSuggestion(
        name: 'School (WeThinkCode_)',
        location: LatLng(-25.7538, 28.1887),
      ),
    ),
    (
      icon: Icons.work,
      place: PlaceSuggestion(
        name: 'Work (IBM Building)',
        location: LatLng(-26.1117, 28.0571),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (final location in _locations)
          ActionChip(
            backgroundColor: AppColors.white,
            side: const BorderSide(color: AppColors.lightGrey),
            avatar: Icon(
              location.icon,
              color: AppColors.gautrainGold,
              size: 16,
            ),
            label: Text(
              location.place.name.split(' ').first,
              style: const TextStyle(
                color: AppColors.gautrainNavy,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => onSelected(location.place),
          ),
      ],
    );
  }
}
