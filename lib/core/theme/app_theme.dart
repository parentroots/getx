import 'package:flutter/material.dart';

import 'package:getx_template/core/theme/app_radius.dart';
import 'package:getx_template/core/theme/app_typography.dart';
import 'package:getx_template/utils/constants/app_colors.dart';

abstract final class AppTheme {
  static ThemeData get light => _build(
    brightness: Brightness.light,
    background: AppColors.textBorder50,
    surface: AppColors.white,
    text: AppColors.textBorder900,
  );

  static ThemeData get dark => _build(
    brightness: Brightness.dark,
    background: AppColors.textBorder900,
    surface: AppColors.textBorder800,
    text: AppColors.textBorder50,
  );

  static ThemeData _build({
    required Brightness brightness,
    required Color background,
    required Color surface,
    required Color text,
  }) {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: brightness,
      primary: AppColors.primary,
      surface: surface,
      error: brightness == Brightness.light ? AppColors.error500 : AppColors.error300,
      errorContainer: brightness == Brightness.light ? AppColors.error50 : AppColors.error900,
      tertiary: brightness == Brightness.light ? AppColors.warning500 : AppColors.warning300,
      secondary: brightness == Brightness.light ? AppColors.success500 : AppColors.success300,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      textTheme: AppTypography.textTheme(text),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: background,
        foregroundColor: text,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: surface,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
    );
  }
}
