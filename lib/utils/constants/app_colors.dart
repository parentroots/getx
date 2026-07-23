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

  final Color primary;
  final Color primaryHover;
  final Color secondary;
  final Color background;
  final Color surface;
  final Color surfaceSecondary;
  final Color border;
  final Color text;
  final Color textSecondary;
  final Color textMuted;
  final Color success;
  final Color warning;
  final Color error;
  final Color info;
  final Color accent;
  final Color tertiary;

  // ===================== DARK THEME =====================

  static const ThemeColor dark = ThemeColor(
    primary: Color(0xFF22C55E),
    primaryHover: Color(0xFF16A34A),
    secondary: Color(0xFF94A3B8),

    background: Color(0xFF0F172A),
    surface: Color(0xFF1E293B),
    surfaceSecondary: Color(0xFF334155),
    border: Color(0xFF475569),

    text: Color(0xFFF8FAFC),
    textSecondary: Color(0xFFCBD5E1),
    textMuted: Color(0xFF94A3B8),

    success: Color(0xFF22C55E),
    warning: Color(0xFFF59E0B),
    error: Color(0xFFEF4444),
    info: Color(0xFF38BDF8),

    accent: Color(0xFF6366F1),
    tertiary: Color(0xFF8B5CF6),
  );

  // ===================== LIGHT THEME =====================

  static const ThemeColor light = ThemeColor(
    primary: Color(0xFF16A34A),
    primaryHover: Color(0xFF15803D),
    secondary: Color(0xFF64748B),

    background: Color(0xFFF8FAFC),
    surface: Color(0xFFFFFFFF),
    surfaceSecondary: Color(0xFFF1F5F9),
    border: Color(0xFFE2E8F0),

    text: Color(0xFF0F172A),
    textSecondary: Color(0xFF475569),
    textMuted: Color(0xFF64748B),

    success: Color(0xFF16A34A),
    warning: Color(0xFFD97706),
    error: Color(0xFFDC2626),
    info: Color(0xFF0284C7),

    accent: Color(0xFF4F46E5),
    tertiary: Color(0xFF7C3AED),
  );

  // ===================== COMMON COLORS =====================

  Color get transparent => Colors.transparent;
  Color get white => Colors.white;
  Color get black => Colors.black;
  Color get red => Colors.red;

  // ===================== COPY WITH =====================

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

  // ===================== LERP =====================

  @override
  ThemeColor lerp(
      ThemeExtension<ThemeColor>? other,
      double t,
      ) {
    if (other is! ThemeColor) return this;

    return ThemeColor(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryHover: Color.lerp(primaryHover, other.primaryHover, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceSecondary:
      Color.lerp(surfaceSecondary, other.surfaceSecondary, t)!,
      border: Color.lerp(border, other.border, t)!,
      text: Color.lerp(text, other.text, t)!,
      textSecondary:
      Color.lerp(textSecondary, other.textSecondary, t)!,
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