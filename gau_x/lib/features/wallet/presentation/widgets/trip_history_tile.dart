import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/date_labels.dart';
import '../../domain/entities/ledger_entry.dart';

/// One row of wallet history: charges in red, top-ups in green.
class TripHistoryTile extends StatelessWidget {
  const TripHistoryTile({super.key, required this.entry});

  final LedgerEntry entry;

  @override
  Widget build(BuildContext context) {
    final amount = entry.amount.abs().toStringAsFixed(2);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: AppColors.lightGrey,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.directions_transit,
            color: AppColors.gautrainNavy,
          ),
        ),
        title: Text(
          entry.description,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.gautrainNavy,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            relativeDateLabel(entry.timestamp, now: DateTime.now()),
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              entry.isCharge ? 'R $amount' : '+R $amount',
              style: TextStyle(
                color: entry.isCharge ? Colors.redAccent : Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
