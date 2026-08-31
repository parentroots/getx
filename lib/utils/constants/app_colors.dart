import 'package:flutter/material.dart';

@immutable
class ThemeColor extends ThemeExtension<ThemeColor> {
  const ThemeColor({
    required this.primary,
    required this.primaryHover,
    required this.secondary,
    required this.background,
    required this.surface,
    required this.surfaceSecondary,
    required this.border,
    required this.text,
    required this.textSecondary,
    required this.textMuted,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    required this.accent,
    required this.tertiary,
  });

  // ===================== PRIMARY COLORS =====================

  final Color primary;
  final Color primaryHover;
  final Color secondary;

  // ===================== BACKGROUND COLORS =====================

  final Color background;
  final Color surface;
  final Color surfaceSecondary;
  final Color border;

  // ===================== TEXT COLORS =====================

  final Color text;
  final Color textSecondary;
  final Color textMuted;

  // ===================== STATUS COLORS =====================

  final Color success;
  final Color warning;
  final Color error;
  final Color info;

  // ===================== ACCENT COLORS =====================

  final Color accent;
  final Color tertiary;

  // ==========================================================
  // DARK THEME
  // "Facebook Midnight"
  // Professional Blue + Deep Dark
  // ==========================================================

  static const ThemeColor dark = ThemeColor(
    // Primary
    primary: Color(0xFF1877F2),
    primaryHover: Color(0xFF0D65D9),
    secondary: Color(0xFF8AB4F8),

    // Background
    background: Color(0xFF18191A),
    surface: Color(0xFF242526),
    surfaceSecondary: Color(0xFF3A3B3C),
    border: Color(0xFF3E4042),

    // Text
    text: Color(0xFFF5F6F7),
    textSecondary: Color(0xFFB8BBBF),
    textMuted: Color(0xFF8A8D91),

    // Status
    success: Color(0xFF42B72A),
    warning: Color(0xFFF7B928),
    error: Color(0xFFFA383E),
    info: Color(0xFF4599FF),

    // Accent
    accent: Color(0xFF4599FF),
    tertiary: Color(0xFF0866FF),
  );

  // ==========================================================
  // LIGHT THEME
  // "Facebook Clean"
  // Professional Blue + Soft Gray
  // ==========================================================

  static const ThemeColor light = ThemeColor(
    // Primary
    primary: Color(0xFF1877F2),
    primaryHover: Color(0xFF0D65D9),
    secondary: Color(0xFF65676B),

    // Background
    background: Color(0xFFF0F2F5),
    surface: Color(0xFFFFFFFF),
    surfaceSecondary: Color(0xFFF5F6F7),
    border: Color(0xFFDADDE1),

    // Text
    text: Color(0xFF1C1E21),
    textSecondary: Color(0xFF65676B),
    textMuted: Color(0xFF8A8D91),

    // Status
    success: Color(0xFF42B72A),
    warning: Color(0xFFF7B928),
    error: Color(0xFFFA383E),
    info: Color(0xFF1877F2),

    // Accent
    accent: Color(0xFF4599FF),
    tertiary: Color(0xFF0866FF),
  );

  // ==========================================================
  // COMMON COLORS
  // ==========================================================

  Color get transparent => Colors.transparent;

  Color get white => Colors.white;

  Color get black => Colors.black;

  Color get red => Colors.red;

  // ==========================================================
  // COPY WITH
  // ==========================================================

  @override
  ThemeColor copyWith({
    Color? primary,
    Color? primaryHover,
    Color? secondary,
    Color? background,
    Color? surface,
    Color? surfaceSecondary,
    Color? border,
    Color? text,
    Color? textSecondary,
    Color? textMuted,
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
    Color? accent,
    Color? tertiary,
  }) {
    return ThemeColor(
      primary: primary ?? this.primary,
      primaryHover: primaryHover ?? this.primaryHover,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceSecondary: surfaceSecondary ?? this.surfaceSecondary,
      border: border ?? this.border,
      text: text ?? this.text,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
      accent: accent ?? this.accent,
      tertiary: tertiary ?? this.tertiary,
    );
  }

  // ==========================================================
  // LERP
  // ==========================================================

  @override
  ThemeColor lerp(ThemeExtension<ThemeColor>? other, double t) {
    if (other is! ThemeColor) {
      return this;
    }

    return ThemeColor(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryHover: Color.lerp(primaryHover, other.primaryHover, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceSecondary: Color.lerp(
        surfaceSecondary,
        other.surfaceSecondary,
        t,
      )!,
      border: Color.lerp(border, other.border, t)!,
      text: Color.lerp(text, other.text, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      info: Color.lerp(info, other.info, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      tertiary: Color.lerp(tertiary, other.tertiary, t)!,
    );
  }
}
