import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonDropdown<T> extends StatelessWidget {
  const CommonDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    required this.itemBuilder,
    this.label,
    this.hint,
    this.validator,
    this.prefixIcon,
    this.fillColor,
    this.borderColor,
    this.focusBorderColor,
    this.errorBorderColor,
    this.borderRadius = 12.0,
    this.contentPadding,
  });

  final List<T> items;
  final T? value;
  final void Function(T?) onChanged;
  final DropdownMenuItem<T> Function(T) itemBuilder;

  final String? label;
  final String? hint;
  final String? Function(T?)? validator;

  final IconData? prefixIcon;

  final Color? fillColor;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? errorBorderColor;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final defaultBorderColor =
        borderColor ?? (isDark ? Colors.grey.shade700 : Colors.grey.shade300);
    final defaultFocusColor = focusBorderColor ?? theme.primaryColor;
    final defaultErrorColor = errorBorderColor ?? theme.colorScheme.error;
    final defaultFillColor =
        fillColor ?? (isDark ? Colors.grey.shade800 : Colors.grey.shade50);

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

    return DropdownButtonFormField<T>(
      value: value,
      items: items.map((item) => itemBuilder(item)).toList(),
      onChanged: onChanged,
      validator: validator,
      icon: Icon(Icons.keyboard_arrow_down_rounded, size: 24.r),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: defaultFillColor,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 22.r) : null,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        border: border,
        enabledBorder: border,
        focusedBorder: focusBorder,
        errorBorder: errorBorder,
      ),
      dropdownColor: isDark ? Colors.grey.shade800 : Colors.white,
      borderRadius: BorderRadius.circular(responsiveBorderRadius),
    );
  }
}
