import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    this.label,
    this.hint,
    this.controller,
    this.initialValue,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.focusNode,
    this.readOnly = false,
    this.autoFocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.inputFormatters,
    this.textAlign = TextAlign.start,
    this.fillColor,
    this.filled = true,
    this.borderColor,
    this.focusBorderColor,
    this.errorBorderColor,
    this.borderRadius = 12.0,
    this.contentPadding,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.errorStyle,
    this.prefixWidget,
    this.suffixWidget,
  });

  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final String? initialValue;
  final String? Function(String?)? validator;
  
  final IconData? prefixIcon;
  final Widget? prefixWidget;
  final IconData? suffixIcon;
  final Widget? suffixWidget;
  
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final VoidCallback? onTap;
  
  final FocusNode? focusNode;
  final bool readOnly;
  final bool autoFocus;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;
  
  final Color? fillColor;
  final bool filled;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? errorBorderColor;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? errorStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final defaultBorderColor = borderColor ?? (isDark ? Colors.grey.shade700 : Colors.grey.shade300);
    final defaultFocusColor = focusBorderColor ?? theme.primaryColor;
    final defaultErrorColor = errorBorderColor ?? theme.colorScheme.error;
    final defaultFillColor = fillColor ?? (isDark ? Colors.grey.shade800 : Colors.grey.shade50);

    final responsiveBorderRadius = borderRadius.r;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(responsiveBorderRadius),
      borderSide: BorderSide(color: defaultBorderColor, width: 1.r),
    );

    final focusBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(responsiveBorderRadius),
      borderSide: BorderSide(color: defaultFocusColor, width: 1.5.r),
    );

    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(responsiveBorderRadius),
      borderSide: BorderSide(color: defaultErrorColor, width: 1.5.r),
    );

    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      focusNode: focusNode,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onFieldSubmitted: onSubmitted,
      onTap: onTap,
      readOnly: readOnly,
      autofocus: autoFocus,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      textAlign: textAlign,
      style: (textStyle ?? theme.textTheme.bodyLarge)?.copyWith(
        fontSize: (textStyle?.fontSize ?? theme.textTheme.bodyLarge?.fontSize ?? 16).sp,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: (labelStyle ?? theme.textTheme.bodyMedium)?.copyWith(
          color: Colors.grey.shade600,
          fontSize: (labelStyle?.fontSize ?? theme.textTheme.bodyMedium?.fontSize ?? 14).sp,
        ),
        hintText: hint,
        hintStyle: (hintStyle ?? theme.textTheme.bodyMedium)?.copyWith(
          color: Colors.grey.shade500,
          fontSize: (hintStyle?.fontSize ?? theme.textTheme.bodyMedium?.fontSize ?? 14).sp,
        ),
        errorStyle: errorStyle?.copyWith(
          fontSize: (errorStyle?.fontSize ?? 12).sp,
        ),
        filled: filled,
        fillColor: defaultFillColor,
        contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        prefixIcon: prefixWidget ?? (prefixIcon != null ? Icon(prefixIcon, size: 22.r) : null),
        suffixIcon: suffixWidget ?? (suffixIcon != null ? Icon(suffixIcon, size: 22.r) : null),
        border: border,
        enabledBorder: border,
        focusedBorder: focusBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
      ),
    );
  }
}
