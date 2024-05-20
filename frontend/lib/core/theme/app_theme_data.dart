import 'package:flutter/material.dart';
import 'package:masinqo/core/theme/app_colors.dart';

class AppThemeData {
  static final listnerTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.listener1,
      primary: AppColors.listener1,
      primaryContainer: AppColors.listener2,
      brightness: Brightness.dark,
    ),
    textTheme: const TextTheme(
      displayMedium: TextStyle(
        fontSize: 40,
        fontWeight: FontWeight.w500,
      ),
    ),
    scaffoldBackgroundColor: AppColors.blackLight,
    iconTheme: const IconThemeData(
      color: AppColors.listener1,
      size: 28,
    ),
    snackBarTheme: const SnackBarThemeData(
      contentTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
    ),
  );
}
