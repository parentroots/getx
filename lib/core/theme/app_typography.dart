import 'package:flutter/material.dart';

//this is comment==============================
//App Typography System
//Font size scale: Heading (largest) > Sub-heading > Text (smallest)
//Weight scale: Regular(400) < Medium(500) < SemiBold(600) < Bold(700)
//Change `fontFamily` below if tumi custom font use koro (e.g. Poppins, Inter etc.)
//this is comment==============================

class AppTypography {
  AppTypography._();

  static const String _fontFamily = 'Roboto'; // <-- replace with your font

  static const double _heading1 = 32;
  static const double _heading2 = 28;
  static const double _heading3 = 24;
  static const double _heading4 = 20;
  static const double _heading5 = 18;

  static const double _subHeading1 = 17;
  static const double _subHeading2 = 16;

  static const double _text1 = 16;
  static const double _text2 = 14;
  static const double _text3 = 13;
  static const double _text4 = 12;


  static TextStyle _base({
    required double size,
    required FontWeight weight,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: size,
      fontWeight: weight,
      height: height ?? 1.3,
      letterSpacing: letterSpacing ?? 0,
    );
  }


  static TextStyle get headingRegular1 => _base(size: _heading1, weight: FontWeight.w400);
  static TextStyle get headingRegular2 => _base(size: _heading2, weight: FontWeight.w400);
  static TextStyle get headingRegular3 => _base(size: _heading3, weight: FontWeight.w400);
  static TextStyle get headingRegular4 => _base(size: _heading4, weight: FontWeight.w400);
  static TextStyle get headingRegular5 => _base(size: _heading5, weight: FontWeight.w400);

  static TextStyle get subHeadingRegular1 => _base(size: _subHeading1, weight: FontWeight.w400);
  static TextStyle get subHeadingRegular2 => _base(size: _subHeading2, weight: FontWeight.w400);

  static TextStyle get textRegular1 => _base(size: _text1, weight: FontWeight.w400);
  static TextStyle get textRegular2 => _base(size: _text2, weight: FontWeight.w400);
  static TextStyle get textRegular3 => _base(size: _text3, weight: FontWeight.w400);
  static TextStyle get textRegular4 => _base(size: _text4, weight: FontWeight.w400);


  static TextStyle get headingMedium1 => _base(size: _heading1, weight: FontWeight.w500);
  static TextStyle get headingMedium2 => _base(size: _heading2, weight: FontWeight.w500);
  static TextStyle get headingMedium3 => _base(size: _heading3, weight: FontWeight.w500);
  static TextStyle get headingMedium4 => _base(size: _heading4, weight: FontWeight.w500);
  static TextStyle get headingMedium5 => _base(size: _heading5, weight: FontWeight.w500);

  static TextStyle get subHeadingMedium1 => _base(size: _subHeading1, weight: FontWeight.w500);
  static TextStyle get subHeadingMedium2 => _base(size: _subHeading2, weight: FontWeight.w500);

  static TextStyle get textMedium1 => _base(size: _text1, weight: FontWeight.w500);
  static TextStyle get textMedium2 => _base(size: _text2, weight: FontWeight.w500);
  static TextStyle get textMedium3 => _base(size: _text3, weight: FontWeight.w500);
  static TextStyle get textMedium4 => _base(size: _text4, weight: FontWeight.w500);


  static TextStyle get headingSemiBold1 => _base(size: _heading1, weight: FontWeight.w600);
  static TextStyle get headingSemiBold2 => _base(size: _heading2, weight: FontWeight.w600);
  static TextStyle get headingSemiBold3 => _base(size: _heading3, weight: FontWeight.w600);
  static TextStyle get headingSemiBold4 => _base(size: _heading4, weight: FontWeight.w600);
  static TextStyle get headingSemiBold5 => _base(size: _heading5, weight: FontWeight.w600);

  static TextStyle get subHeadingSemiBold1 => _base(size: _subHeading1, weight: FontWeight.w600);
  static TextStyle get subHeadingSemiBold2 => _base(size: _subHeading2, weight: FontWeight.w600);

  static TextStyle get textSemiBold1 => _base(size: _text1, weight: FontWeight.w600);
  static TextStyle get textSemiBold2 => _base(size: _text2, weight: FontWeight.w600);
  static TextStyle get textSemiBold3 => _base(size: _text3, weight: FontWeight.w600);
  static TextStyle get textSemiBold4 => _base(size: _text4, weight: FontWeight.w600);

  static TextStyle get headingBold1 => _base(size: _heading1, weight: FontWeight.w700);
  static TextStyle get headingBold2 => _base(size: _heading2, weight: FontWeight.w700);
  static TextStyle get headingBold3 => _base(size: _heading3, weight: FontWeight.w700);
  static TextStyle get headingBold4 => _base(size: _heading4, weight: FontWeight.w700);
  static TextStyle get headingBold5 => _base(size: _heading5, weight: FontWeight.w700);

  static TextStyle get subHeadingBold1 => _base(size: _subHeading1, weight: FontWeight.w700);
  static TextStyle get subHeadingBold2 => _base(size: _subHeading2, weight: FontWeight.w700);

  static TextStyle get textBold1 => _base(size: _text1, weight: FontWeight.w700);
  static TextStyle get textBold2 => _base(size: _text2, weight: FontWeight.w700);
  static TextStyle get textBold3 => _base(size: _text3, weight: FontWeight.w700);
  static TextStyle get textBold4 => _base(size: _text4, weight: FontWeight.w700);


  static TextTheme textTheme(Color color) {
    return TextTheme(
      displayLarge: headingBold1.copyWith(color: color),
      displayMedium: headingBold2.copyWith(color: color),
      displaySmall: headingBold3.copyWith(color: color),
      headlineLarge: headingBold4.copyWith(color: color),
      headlineMedium: headingMedium1.copyWith(color: color),
      headlineSmall: headingMedium2.copyWith(color: color),
      titleLarge: headingSemiBold5.copyWith(color: color),
      titleMedium: subHeadingMedium1.copyWith(color: color),
      titleSmall: subHeadingMedium2.copyWith(color: color),
      bodyLarge: textRegular1.copyWith(color: color),
      bodyMedium: textRegular2.copyWith(color: color),
      bodySmall: textRegular4.copyWith(color: color),
      labelLarge: textMedium2.copyWith(color: color),
      labelSmall: textRegular4.copyWith(color: color),
    );
  }


}
