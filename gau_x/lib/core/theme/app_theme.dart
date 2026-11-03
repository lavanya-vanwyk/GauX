import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// The app's single source of theme data. Mirrors the theme that previously
/// lived inline in `main.dart`, so screens look the same as the judged build.
abstract final class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.gautrainGold,
      scaffoldBackgroundColor: AppColors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.gautrainNavy,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.gautrainGold,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
