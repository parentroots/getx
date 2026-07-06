import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:getx_template/component/layout/common_text.dart';

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
    final isDark = theme.brightness == Brightness.dark;

    final defaultFillColor = widget.fillColor ??
        (isDark ? Colors.grey.shade800 : Colors.grey.shade50);
    final defaultBorderColor = widget.borderColor ??
        (isDark ? Colors.grey.shade700 : Colors.grey.shade300);

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
            variant: TextVariant.body,
            weight: TextWeight.medium,
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
            color: Colors.grey,
          ),
          pickerDialogStyle: PickerDialogStyle(
            backgroundColor: isDark ? Colors.grey.shade900 : Colors.white,
            countryNameStyle: theme.textTheme.bodyMedium,
            countryCodeStyle: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
            searchFieldInputDecoration: InputDecoration(
              hintText: 'Search country name or code...',
              hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              filled: true,
              fillColor: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          decoration: InputDecoration(
            hintText: widget.hintText ?? 'Enter number',
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade400,
              fontSize: 14.sp,
            ),
            filled: true,
            fillColor: defaultFillColor,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            border: borderDecoration,
            enabledBorder: borderDecoration,
            focusedBorder: borderDecoration.copyWith(
              borderSide: BorderSide(color: theme.primaryColor, width: 1.5.r),
            ),
            errorBorder: borderDecoration.copyWith(
              borderSide: BorderSide(color: theme.colorScheme.error, width: 1.r),
            ),
            focusedErrorBorder: borderDecoration.copyWith(
              borderSide: BorderSide(color: theme.colorScheme.error, width: 1.5.r),
            ),
          ),
        ),
      ],
    );
  }
}
