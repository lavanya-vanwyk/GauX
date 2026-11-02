import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/place_suggestion.dart';

/// Autocomplete results under the search field.
class PlaceSuggestionList extends StatelessWidget {
  const PlaceSuggestionList({
    super.key,
    required this.suggestions,
    required this.maxHeight,
    required this.onSelected,
  });

  final List<PlaceSuggestion> suggestions;
  final double maxHeight;
  final ValueChanged<PlaceSuggestion> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: suggestions.length,
        separatorBuilder: (_, _) =>
            const Divider(height: 1, color: AppColors.lightGrey),
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ListTile(
            leading: const Icon(
              Icons.location_on,
              color: AppColors.gautrainGold,
            ),
            title: Text(
              suggestion.name,
              style: const TextStyle(
                color: AppColors.gautrainNavy,
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () => onSelected(suggestion),
          );
        },
      ),
    );
  }
}
