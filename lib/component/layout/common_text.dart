import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonText extends StatelessWidget {
  const CommonText(
    this.text, {
    super.key,
    this.style,
    this.fontWeight,
    this.color,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.height,
    this.fontStyle,
    this.decoration,
  });

  final String text;
  final TextStyle? style;
  final FontWeight? fontWeight;
  final Color? color;
  final double? fontSize;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? height;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseStyle = style ?? theme.textTheme.bodyMedium ?? const TextStyle();

    final double? baseFontSize = fontSize ?? baseStyle.fontSize;

    // Apply custom overrides
    final finalStyle = baseStyle.copyWith(
      color: color ?? baseStyle.color,
      fontSize: baseFontSize?.sp,
      fontWeight: fontWeight ?? baseStyle.fontWeight,
      height: height ?? baseStyle.height,
      fontStyle: fontStyle ?? baseStyle.fontStyle,
      decoration: decoration ?? baseStyle.decoration,
    );

    return Text(
      text,
      style: finalStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
