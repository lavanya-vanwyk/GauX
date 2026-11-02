import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

/// Shows that rides are paid from the GauX wallet.
class PaymentMethodRow extends StatelessWidget {
  const PaymentMethodRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.account_balance_wallet, color: AppColors.gautrainGold),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment method',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  'GauX Digital Wallet',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        Icon(Icons.chevron_right, color: Colors.grey),
      ],
    );
  }
}
