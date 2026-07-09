import 'package:flutter/material.dart';
import 'package:getx_template/utils/extensions/context_extensions.dart';

class AppColors {
  AppColors._();

  // --- Main Colors (Preserved) ---
  static const Color primary = Color(0xFF2563EB); // Main Primary (Blue)
  static const Color primaryColor = Color(0xFFFFBF00); // Amber Primary
  static const Color secondary = Color(0xff454545);
  static const Color background = Color(0xFFFAFAFA);
  static const Color transparent = Colors.transparent;
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color red = Colors.red;
  static const Color filledColor = Color(0xFFe7e7e7);
  static const Color textFiledColor = Color(0xFF979797);
  static const Color blueLight = Color(0xffe8e8f5);
  static const Color primaryGrey = Color(0xFF757680);
  static const Color backGroundColor = Color(0xfffbf4f9);
  static const Color greyColor = Color(0xFF6B7280);

  // Status & Highlight Colors (Preserved fallback)
  static const Color accent = Color(0xFFF59E0B);
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFF97316);
  static const Color error = Color(0xFFDC2626);
  static const Color info = Color(0xFF0284C7);

  // Surface & Theme backgrounds (Preserved fallback)
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Colors.white;
  static const Color darkBackground = Color(0xFF0B1120);
  static const Color darkSurface = Color(0xFF111827);
  
  // Text & Border Colors (Preserved fallback)
  static const Color textDark = Color(0xFF0F172A);
  static const Color textLight = Color(0xFFF8FAFC);
  static const Color muted = Color(0xFF64748B);
  static const Color border = Color(0xFFE2E8F0);



  // --- NEW CUSTOM PALETTE ---

  // --- Error Shades ---
  static const Color error50 = Color(0xFFFAE6E6);
  static const Color error_50 = error50;
  static const Color error100 = Color(0xFFEFB0B0);
  static const Color error_100 = error100;
  static const Color error200 = Color(0xFFE88A8A);
  static const Color error_200 = error200;
  static const Color error300 = Color(0xFFDD5454);
  static const Color error_300 = error300;
  static const Color error400 = Color(0xFFD63333);
  static const Color error_400 = error400;
  static const Color error500 = Color(0xFFCC0000);
  static const Color error_500 = error500;
  static const Color error600 = Color(0xFFBA0000);
  static const Color error_600 = error600;
  static const Color error700 = Color(0xFF910000);
  static const Color error_700 = error700;
  static const Color error800 = Color(0xFF700000);
  static const Color error_800 = error800;
  static const Color error900 = Color(0xFF560000);
  static const Color error_900 = error900;

  // --- Warning Shades ---
  static const Color warning50 = Color(0xFFFBFBE8);
  static const Color warning_50 = warning50;
  static const Color warning100 = Color(0xFFF1F2B6);
  static const Color warning_100 = warning100;
  static const Color warning200 = Color(0xFFEAEC93);
  static const Color warning_200 = warning200;
  static const Color warning300 = Color(0xFFE1E362);
  static const Color warning_300 = warning300;
  static const Color warning400 = Color(0xFFDBDD44);
  static const Color warning_400 = warning400;
  static const Color warning500 = Color(0xFFD2D515);
  static const Color warning_500 = warning500;
  static const Color warning600 = Color(0xFFBFC213);
  static const Color warning_600 = warning600;
  static const Color warning700 = Color(0xFF95970F);
  static const Color warning_700 = warning700;
  static const Color warning800 = Color(0xFF74750C);
  static const Color warning_800 = warning800;
  static const Color warning900 = Color(0xFF585909);
  static const Color warning_900 = warning900;

  // --- Success Shades ---
  static const Color success50 = Color(0xFFE9F7F5);
  static const Color success_50 = success50;
  static const Color success100 = Color(0xFFBAE7DE);
  static const Color success_100 = success100;
  static const Color success200 = Color(0xFF98DCCF);
  static const Color success_200 = success200;
  static const Color success300 = Color(0xFF69CCB9);
  static const Color success_300 = success300;
  static const Color success400 = Color(0xFF4CC2AB);
  static const Color success_400 = success400;
  static const Color success500 = Color(0xFF1FB396);
  static const Color success_500 = success500;
  static const Color success600 = Color(0xFF1CA389);
  static const Color success_600 = success600;
  static const Color success700 = Color(0xFF167F6B);
  static const Color success_700 = success700;
  static const Color success800 = Color(0xFF116253);
  static const Color success_800 = success800;
  static const Color success900 = Color(0xFF0D4B3F);
  static const Color success_900 = success900;

  // --- Text & Border (Neutral) Shades ---
  static const Color textBorder50 = Color(0xFFF2F2F2);
  static const Color text_border_50 = textBorder50;
  static const Color textBorder100 = Color(0xFFD7D7D7);
  static const Color text_border_100 = textBorder100;
  static const Color textBorder200 = Color(0xFFC3C3C3);
  static const Color text_border_200 = textBorder200;
  static const Color textBorder300 = Color(0xFFA8A8A8);
  static const Color text_border_300 = textBorder300;
  static const Color textBorder400 = Color(0xFF979797);
  static const Color text_border_400 = textBorder400;
  static const Color textBorder500 = Color(0xFF7D7D7D);
  static const Color text_border_500 = textBorder500;
  static const Color textBorder600 = Color(0xFF727272);
  static const Color text_border_600 = textBorder600;
  static const Color textBorder700 = Color(0xFF595959);
  static const Color text_border_700 = textBorder700;
  static const Color textBorder800 = Color(0xFF454545);
  static const Color text_border_800 = textBorder800;
  static const Color textBorder900 = Color(0xFF353535);
  static const Color text_border_900 = textBorder900;



  static Color themeBackground(BuildContext context) =>
      context.isDarkMode ? textBorder900 : textBorder50;

  static Color themeSurface(BuildContext context) =>
      context.isDarkMode ? textBorder800 : white;

  static Color themeText(BuildContext context) =>
      context.isDarkMode ? textBorder50 : textBorder900;

  static Color themeBorder(BuildContext context) =>
      context.isDarkMode ? textBorder700 : textBorder100;


}
