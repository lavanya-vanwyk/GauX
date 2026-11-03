import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// Top Up / Timetable / Help shortcuts under the wallet card. A null
/// [onTopUp] hides the Top Up action.
class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({super.key, required this.onTopUp});

  final VoidCallback? onTopUp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (onTopUp case final onTopUp?)
          _QuickAction(
            icon: Icons.account_balance_wallet,
            label: 'Top Up',
            onTap: onTopUp,
          ),
        // Not built yet
        _QuickAction(
          icon: Icons.calendar_today,
          label: 'Timetable',
          onTap: () {},
        ),
        _QuickAction(icon: Icons.headset_mic, label: 'Help', onTap: () {}),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: AppColors.gautrainNavy, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.gautrainNavy,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
