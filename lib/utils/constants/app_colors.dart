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
    required this.textColor,
    required this.textSecondary,
    required this.textMuted,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    required this.accent,
    required this.testColor,
  });

  final Color primary;
  final Color primaryHover;
  final Color secondary;
  final Color background;
  final Color surface;
  final Color surfaceSecondary;
  final Color border;
  final Color textColor;
  final Color textSecondary;
  final Color textMuted;
  final Color success;
  final Color warning;
  final Color error;
  final Color info;
  final Color accent;
  final Color testColor;

  // ── Dark ===============================================
  static const ThemeColor dark = ThemeColor(
    primary: Color(0xFF3B82F6),
    primaryHover: Color(0xFF60A5FA),
    secondary: Color(0xFF94A3B8),
    background: Color(0xFF0B1329),
    surface: Color(0xFF111827),
    surfaceSecondary: Color(0xFF1F2937),
    border: Color(0xFF374151),
    textColor: Color(0xFFF40000),
    textSecondary: Color(0xFF94A3B8),
    textMuted: Color(0xFF64748B),
    success: Color(0xFF10B981),
    warning: Color(0xFFFBBF24),
    error: Color(0xFFF43F5E),
    info: Color(0xFF38BDF8),
    accent: Color(0xFF6366F1),
    testColor: Color(0XFF4BF301),
  );

  // ── Light ==============================================
  static const ThemeColor light = ThemeColor(
    primary: Color(0xFF2563EB),
    primaryHover: Color(0xFF1D4ED8),
    secondary: Color(0xFF475569),
    background: Color(0xFFF8FAFC),
    surface: Color(0xFFFFFFFF),
    surfaceSecondary: Color(0xFFF1F5F9),
    border: Color(0xFFE2E8F0),
    textColor: Color(0xFF4BF301),
    textSecondary: Color(0xFF64748B),
    textMuted: Color(0xFF94A3B8),
    success: Color(0xFF059669),
    warning: Color(0xFFF59E0B),
    error: Color(0xFFE11D48),
    info: Color(0xFF0284C7),
    accent: Color(0xFF4F46E5),
    testColor: Color(0xFFB700FF),
  );

  // ── Common Colors (Same in both Light and Dark mode) ===
  Color get transparent => Colors.transparent;

  Color get white => Colors.white;

  Color get black => Colors.black;

  Color get red => Colors.red;

  @override
  ThemeColor copyWith({
    Color? primary,
    Color? primaryHover,
    Color? secondary,
    Color? background,
    Color? surface,
    Color? surfaceSecondary,
    Color? border,
    Color? textColor,
    Color? textSecondary,
    Color? textMuted,
    Color? success,
    Color? warning,
    Color? error,
    Color? info,
    Color? accent,
    Color? testColor,
  }) {
    return ThemeColor(
      primary: primary ?? this.primary,
      primaryHover: primaryHover ?? this.primaryHover,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceSecondary:
          surfaceSecondary ?? this.surfaceSecondary,
      border: border ?? this.border,
      textColor: textColor ?? this.textColor,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      info: info ?? this.info,
      accent: accent ?? this.accent,
      testColor: testColor ?? this.testColor,
    );
  }

  @override
  ThemeColor lerp(
    ThemeExtension<ThemeColor>? other,
    double t,
  ) {
    if (other is! ThemeColor) return this;
    return ThemeColor(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryHover: Color.lerp(
        primaryHover,
        other.primaryHover,
        t,
      )!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      background: Color.lerp(
        background,
        other.background,
        t,
      )!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceSecondary: Color.lerp(
        surfaceSecondary,
        other.surfaceSecondary,
        t,
      )!,
      border: Color.lerp(border, other.border, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      textSecondary: Color.lerp(
        textSecondary,
        other.textSecondary,
        t,
      )!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      error: Color.lerp(error, other.error, t)!,
      info: Color.lerp(info, other.info, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      testColor: Color.lerp(testColor, other.testColor, t)!,
    );
  }
}
