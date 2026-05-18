import 'package:flutter/material.dart';

abstract final class AppTypography {
  static TextTheme textTheme(Color color) {
    return TextTheme(

      displaySmall: TextStyle(fontSize: 36, fontWeight: FontWeight.w800, color: color,),
      headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: color,),
      titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: color,),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: color,),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: color,),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: color,),
      bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: color,),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: color,),
      bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: color,),
      labelSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: color,),

    );
  }
}
