import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TextVariant { display, header, title, body, caption, overline, }

enum TextWeight { light, regular, medium, bold }

class CommonText extends StatelessWidget {
  const CommonText(
    this.text, {
    super.key,
    this.variant = TextVariant.body,
    this.weight = TextWeight.regular,
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
  final TextVariant variant;
  final TextWeight weight;
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
    
    // Determine Base TextStyle from Theme according to variant
    TextStyle baseStyle;
    switch (variant) {
      case TextVariant.display:
        baseStyle = theme.textTheme.displayMedium ?? const TextStyle();
        break;
      case TextVariant.header:
        baseStyle = theme.textTheme.headlineMedium ?? const TextStyle();
        break;
      case TextVariant.title:
        baseStyle = theme.textTheme.titleMedium ?? const TextStyle();
        break;
      case TextVariant.caption:
        baseStyle = theme.textTheme.bodySmall ?? const TextStyle();
        break;
      case TextVariant.overline:
        baseStyle = theme.textTheme.labelSmall ?? const TextStyle();
        break;
      case TextVariant.body:
      default:
        baseStyle = theme.textTheme.bodyMedium ?? const TextStyle();
        break;
    }

    // Determine FontWeight
    FontWeight fontWeight;
    switch (weight) {
      case TextWeight.light:
        fontWeight = FontWeight.w300;
        break;
      case TextWeight.medium:
        fontWeight = FontWeight.w500;
        break;
      case TextWeight.bold:
        fontWeight = FontWeight.w700;
        break;
      case TextWeight.regular:
      default:
        fontWeight = FontWeight.w400;
        break;
    }

    final double? baseFontSize = fontSize ?? baseStyle.fontSize;

    // Apply custom overrides
    final finalStyle = baseStyle.copyWith(
      color: color ?? baseStyle.color,
      fontSize: baseFontSize?.sp,
      fontWeight: fontWeight,
      height: height ?? baseStyle.height,
      fontStyle: fontStyle,
      decoration: decoration,
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
