import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_template/component/layout/app_text.dart';

/// A country model containing dialing details and matching regex validations.
class CountryPhoneCode {
  const CountryPhoneCode({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.flag,
    required this.regexPattern,
    required this.example,
  });

  final String name;
  final String code;
  final String dialCode;
  final String flag;
  final RegExp regexPattern;
  final String example;
}

/// Seed list of popular, standard countries.
final List<CountryPhoneCode> defaultCountries = [
  CountryPhoneCode(
    name: 'Bangladesh',
    code: 'BD',
    dialCode: '+880',
    flag: '🇧🇩',
    regexPattern: RegExp(r'^(?:1[3-9]\d{8})$'), // Matches 1XXXXXXXXX (10 digits)
    example: '1712345678',
  ),
  CountryPhoneCode(
    name: 'United States',
    code: 'US',
    dialCode: '+1',
    flag: '🇺🇸',
    regexPattern: RegExp(r'^[2-9]\d{9}$'), // Standard 10-digit US number
    example: '2025550191',
  ),
  CountryPhoneCode(
    name: 'United Kingdom',
    code: 'GB',
    dialCode: '+44',
    flag: '🇬🇧',
    regexPattern: RegExp(r'^7\d{9}$'), // Standard UK mobile starts with 7
    example: '7911123456',
  ),
  CountryPhoneCode(
    name: 'India',
    code: 'IN',
    dialCode: '+91',
    flag: '🇮🇳',
    regexPattern: RegExp(r'^[6-9]\d{9}$'), // Standard 10-digit India number
    example: '9876543210',
  ),
  CountryPhoneCode(
    name: 'Canada',
    code: 'CA',
    dialCode: '+1',
    flag: '🇨🇦',
    regexPattern: RegExp(r'^[2-9]\d{9}$'), // Canada matching US number pattern
    example: '6135550142',
  ),
];

/// A premium Phone Input textfield featuring a dynamic country dial-code prefix,
/// a modern searchable bottom sheet picker, and integrated regex pattern validations.
class AppPhoneTextField extends StatefulWidget {
  const AppPhoneTextField({
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

  /// Callback when phone input text changes.
  final ValueChanged<String>? onChanged;

  /// Callback when selected country changes.
  final ValueChanged<CountryPhoneCode>? onCountryChanged;

  /// Optional custom parent validator to combine with regex matching.
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
  State<AppPhoneTextField> createState() => _AppPhoneTextFieldState();
}

class _AppPhoneTextFieldState extends State<AppPhoneTextField> {
  late CountryPhoneCode _selectedCountry;

  @override
  void initState() {
    super.initState();
    _selectedCountry = defaultCountries.firstWhere(
      (c) => c.code.toUpperCase() == widget.initialCountryCode.toUpperCase(),
      orElse: () => defaultCountries.first,
    );
  }

  void _showCountryPicker() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: 400.h,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade900 : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.r),
                  topRight: Radius.circular(24.r),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                    height: 4.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: const AppText(
                      'Select Country',
                      variant: TextVariant.title,
                      weight: TextWeight.bold,
                    ),
                  ),
                  Divider(height: 1.h, thickness: 1.r),
                  Expanded(
                    child: ListView.builder(
                      itemCount: defaultCountries.length,
                      itemBuilder: (context, index) {
                        final country = defaultCountries[index];
                        final isSelected = country.code == _selectedCountry.code;

                        return ListTile(
                          onTap: () {
                            setState(() {
                              _selectedCountry = country;
                            });
                            widget.onCountryChanged?.call(country);
                            Navigator.pop(context);
                          },
                          leading: AppText(
                            country.flag,
                            variant: TextVariant.title,
                          ),
                          title: AppText(
                            country.name,
                            variant: TextVariant.body,
                            weight: isSelected ? TextWeight.bold : TextWeight.regular,
                          ),
                          trailing: AppText(
                            country.dialCode,
                            variant: TextVariant.body,
                            color: isSelected ? theme.primaryColor : Colors.grey,
                            weight: isSelected ? TextWeight.bold : TextWeight.regular,
                          ),
                          selected: isSelected,
                          selectedTileColor: theme.primaryColor.withValues(alpha: 0.05),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  String? _validateInput(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    // Strip out spaces/dashes if any
    final cleaned = value.replaceAll(RegExp(r'\s+|-'), '');

    if (!_selectedCountry.regexPattern.hasMatch(cleaned)) {
      return 'Invalid number. Example: ${_selectedCountry.example}';
    }

    if (widget.validator != null) {
      return widget.validator!(value);
    }

    return null;
  }

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
          AppText(
            widget.label,
            variant: TextVariant.body,
            weight: TextWeight.medium,
          ),
          SizedBox(height: 8.h),
        ],
        TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.phone,
          onChanged: widget.onChanged,
          validator: _validateInput,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 16.sp,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText ?? 'Enter number (e.g. ${_selectedCountry.example})',
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade400,
              fontSize: 14.sp,
            ),
            filled: true,
            fillColor: defaultFillColor,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            prefixIcon: GestureDetector(
              onTap: _showCountryPicker,
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                margin: EdgeInsets.only(right: 8.w),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                      width: 1.r,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      _selectedCountry.flag,
                      variant: TextVariant.title,
                    ),
                    SizedBox(width: 6.w),
                    AppText(
                      _selectedCountry.dialCode,
                      variant: TextVariant.body,
                      weight: TextWeight.bold,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 18.r,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
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
