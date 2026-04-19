import 'package:flutter/material.dart';
import 'colors.dart';


class AppTheme {
  static ThemeData light = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundLight,

    cardColor: AppColors.cardLight,

    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.textPrimaryLight),
    ),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundDark,

    cardColor: AppColors.cardDark,

    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: AppColors.textPrimaryDark),
    ),
  );
}