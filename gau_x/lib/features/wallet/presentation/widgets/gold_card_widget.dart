import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class GoldCardWidget extends StatelessWidget {
  final double balance;

  const GoldCardWidget({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        // Keeping the gold aesthetic but it is now a GauX asset
        gradient: const LinearGradient(
          colors: [Color(0xFFE5C058), Color(0xFFB88A16)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'GAUX DIGITAL WALLET', // Rebranded for the standalone pivot
            style: TextStyle(
              color: AppColors.gautrainNavy,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Current Balance',
            style: TextStyle(
              color: AppColors.gautrainNavy,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'R ${balance.toStringAsFixed(2)}',
            style: const TextStyle(
              color: AppColors.gautrainNavy,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Linked: +27 82 *** 1234', // Represents a mobile-linked digital wallet
            style: TextStyle(color: AppColors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
