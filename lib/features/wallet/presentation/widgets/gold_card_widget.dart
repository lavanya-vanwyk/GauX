import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class GoldCardWidget extends StatelessWidget {
  final double balance;
  
  const GoldCardWidget({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.gautrainGold,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26, 
            blurRadius: 10, 
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'GAUTRAIN GOLD CARD', 
            style: TextStyle(
              color: AppColors.gautrainNavy, 
              fontWeight: FontWeight.bold, 
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Current Balance', 
            style: TextStyle(color: AppColors.white, fontSize: 14),
          ),
          Text(
            'R ${balance.toStringAsFixed(2)}', 
            style: const TextStyle(
              color: AppColors.white, 
              fontSize: 36, 
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            '**** **** **** 1234', 
            style: TextStyle(color: AppColors.gautrainNavy, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
