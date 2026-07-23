import 'package:flutter/material.dart';
import 'package:getx_template/core/theme/app_radius.dart';
import 'package:getx_template/core/theme/app_typography.dart';
import 'package:getx_template/utils/constants/app_colors.dart';

abstract final class AppTheme {
  static ThemeData get light => _build(
        brightness: Brightness.light,
        background: ThemeColor.light.background,
        surface: ThemeColor.light.surface,
        text: ThemeColor.light.text,
        primaryColor: ThemeColor.light.primary,
      );

  static ThemeData get dark => _build(
        brightness: Brightness.dark,
        background: ThemeColor.dark.background,
        surface: ThemeColor.dark.surface,
        text: ThemeColor.dark.text,
        primaryColor: ThemeColor.dark.primary,
      );

  static ThemeData _build({
    required Brightness brightness,
    required Color background,
    required Color surface,
    required Color text,
    required Color primaryColor,
  }) {
    final isLight = brightness == Brightness.light;

    final scheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: brightness,
      primary: primaryColor,
      surface: surface,
      error: isLight ? ThemeColor.light.error : ThemeColor.dark.error,
      errorContainer: isLight
          ? ThemeColor.light.error.withValues(alpha: 0.1)
          : ThemeColor.dark.error.withValues(alpha: 0.2),
      tertiary: isLight ? ThemeColor.light.warning : ThemeColor.dark.warning,
      secondary: isLight ? ThemeColor.light.success : ThemeColor.dark.success,
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
      extensions: [
        isLight ? ThemeColor.light : ThemeColor.dark,
      ],
    );
  }
}
