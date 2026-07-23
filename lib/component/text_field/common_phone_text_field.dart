import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:getx_template/component/layout/common_text.dart';
import 'package:getx_template/utils/extensions/context_extensions.dart';

/// A country model containing dialing details adapted for backward compatibility.
class CountryPhoneCode {
  const CountryPhoneCode({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.flag,
  });

  final String name;
  final String code;
  final String dialCode;
  final String flag;
}

/// A premium international Phone Input textfield leveraging the `intl_phone_field` package.
class CommonPhoneTextField extends StatefulWidget {
  const CommonPhoneTextField({
    super.key,
    required this.controller,
    this.label = 'Phone Number',
    this.hintText,
    this.onChanged,
    this.onCountryChanged,
    this.validator,
    this.initialCountryCode = 'BD',
    this.fillColor,
    this.borderColor,
    this.borderRadius = 12.0,
  });

  /// The text controller managing the phone field input.
  final TextEditingController controller;

  /// Label shown above or inside input frame.
  final String label;

  /// Optional input placeholder.
  final String? hintText;

  /// Callback when phone input text changes. Yields the complete phone number with country prefix.
  final ValueChanged<String>? onChanged;

  /// Callback when selected country changes.
  final ValueChanged<CountryPhoneCode>? onCountryChanged;

  /// Optional custom validator.
  final String? Function(String?)? validator;

  /// ISO 2-letter country code (e.g. 'BD', 'US') to pre-select.
  final String initialCountryCode;

  /// Textfield inner fill color.
  final Color? fillColor;

  /// Normal border color outline.
  final Color? borderColor;

  /// Circular radius (defaults to 12.0).
  final double borderRadius;

  @override
  State<CommonPhoneTextField> createState() => _CommonPhoneTextFieldState();
}

class _CommonPhoneTextFieldState extends State<CommonPhoneTextField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final defaultFillColor = widget.fillColor ?? context.appColors.surfaceSecondary;
    final defaultBorderColor = widget.borderColor ?? context.appColors.border;

    final borderDecoration = OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius.r),
      borderSide: BorderSide(color: defaultBorderColor, width: 1.r),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty) ...[
          CommonText(
            widget.label,
            style: context.textTheme.bodyMedium,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 8.h),
        ],
        IntlPhoneField(
          controller: widget.controller,
          initialCountryCode: widget.initialCountryCode,
          onChanged: (phone) {
            widget.onChanged?.call(phone.completeNumber);
          },
          onCountryChanged: (country) {
            if (widget.onCountryChanged != null) {
              widget.onCountryChanged!(CountryPhoneCode(
                name: country.name,
                code: country.code,
                dialCode: country.dialCode,
                flag: country.flag,
              ));
            }
          },
          validator: (phone) {
            if (widget.validator != null) {
              return widget.validator!(phone?.completeNumber);
            }
            return null;
          },
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 16.sp,
          ),
          dropdownTextStyle: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
          flagsButtonMargin: EdgeInsets.only(left: 8.w),
          showDropdownIcon: true,
          dropdownIcon: Icon(
            Icons.arrow_drop_down,
            size: 18.r,
            color: context.appColors.textSecondary,
          ),
          pickerDialogStyle: PickerDialogStyle(
            backgroundColor: context.appColors.surface,
            countryNameStyle: theme.textTheme.bodyMedium,
            countryCodeStyle: theme.textTheme.bodyMedium?.copyWith(color: context.appColors.textSecondary),
            searchFieldInputDecoration: InputDecoration(
              hintText: 'Search country name or code...',
              hintStyle: TextStyle(fontSize: 14.sp, color: context.appColors.textMuted),
              prefixIcon: Icon(Icons.search, color: context.appColors.textSecondary),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              filled: true,
              fillColor: context.appColors.surfaceSecondary,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          decoration: InputDecoration(
            hintText: widget.hintText ?? 'Enter number',
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: context.appColors.textMuted,
              fontSize: 14.sp,
            ),
            filled: true,
            fillColor: defaultFillColor,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            border: borderDecoration,
            enabledBorder: borderDecoration,
            focusedBorder: borderDecoration.copyWith(
              borderSide: BorderSide(color: context.appColors.primary, width: 1.5.r),
            ),
            errorBorder: borderDecoration.copyWith(
              borderSide: BorderSide(color: context.appColors.error, width: 1.r),
            ),
            focusedErrorBorder: borderDecoration.copyWith(
              borderSide: BorderSide(color: context.appColors.error, width: 1.5.r),
            ),
          ),
        ),
      ],
    );
  }
}
