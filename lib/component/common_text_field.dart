import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_template/core/constants/app_colors.dart';

/// A premium, highly customizable input text field component.
/// Featuring automated password visibility toggles, text casing configurations,
/// autofill prompts, and custom shapes/colors.
class CommonTextField extends StatefulWidget {
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
    this.borderRadius = 8.0,
    this.contentPadding,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.errorStyle,
    this.prefixWidget,
    this.suffixWidget,
    this.textCapitalization = TextCapitalization.none,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.autofillHints,
    this.showPasswordToggle = true,
  });

  /// Label shown above or floating inside input frame.
  final String? label;

  /// Placeholder hint text.
  final String? hint;

  /// Text controller managing the field input.
  final TextEditingController? controller;

  /// Default text inside field on initialize.
  final String? initialValue;

  /// Input validator function.
  final String? Function(String?)? validator;
  
  /// Icon displayed on the prefix edge of input.
  final IconData? prefixIcon;

  /// Custom prefix widget (overrides [prefixIcon]).
  final Widget? prefixWidget;

  /// Icon displayed on the suffix edge of input.
  final IconData? suffixIcon;

  /// Custom suffix widget (overrides [suffixIcon]).
  final Widget? suffixWidget;
  
  /// Obscures characters for sensitive entries (e.g. passwords).
  final bool obscureText;

  /// Type of virtual keyboard layout to show.
  final TextInputType? keyboardType;

  /// Keyboard return action symbol.
  final TextInputAction? textInputAction;
  
  /// Callback on input text modifications.
  final Function(String)? onChanged;

  /// Callback on keyboard submit actions.
  final Function(String)? onSubmitted;

  /// Tap callback inside text field boundaries.
  final VoidCallback? onTap;
  
  /// Keyboard focus manager node.
  final FocusNode? focusNode;

  /// Blocks user typing edits.
  final bool readOnly;

  /// Autofocus the textfield.
  final bool autoFocus;

  /// Maximum visible lines (defaults to 1).
  final int maxLines;

  /// Minimum visible lines.
  final int? minLines;

  /// Absolute limit on text length count.
  final int? maxLength;
  
  /// Standard text input format restrictions.
  final List<TextInputFormatter>? inputFormatters;

  /// Input alignment.
  final TextAlign textAlign;
  
  /// Input fill color.
  final Color? fillColor;

  /// Filled background track active flag.
  final bool filled;

  /// Border outline outline color.
  final Color? borderColor;

  /// Border outline outline color when active.
  final Color? focusBorderColor;

  /// Border outline outline color on errors.
  final Color? errorBorderColor;

  /// Circular track radius (defaults to 12.0).
  final double borderRadius;

  /// Inner padding spacing.
  final EdgeInsetsGeometry? contentPadding;
  
  /// Input text style styling.
  final TextStyle? textStyle;

  /// Inactive placeholder style styling.
  final TextStyle? hintStyle;

  /// Inactive label style styling.
  final TextStyle? labelStyle;

  /// Error label style styling.
  final TextStyle? errorStyle;

  /// Word casing options (defaults to none).
  final TextCapitalization textCapitalization;

  /// Autocorrect input.
  final bool autocorrect;

  /// Enable suggestions.
  final bool enableSuggestions;

  /// Autofill suggestion codes.
  final Iterable<String>? autofillHints;

  /// Enable password eye visibility toggler if obscureText is active.
  final bool showPasswordToggle;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  void didUpdateWidget(covariant CommonTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.obscureText != oldWidget.obscureText) {
      _obscureText = widget.obscureText;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final defaultBorderColor = widget.borderColor ?? (isDark ? Colors.grey.shade500 : Colors.grey.shade300);
    final defaultFocusColor = widget.focusBorderColor ?? AppColors.primary;
    final defaultErrorColor = widget.errorBorderColor ?? AppColors.red;
    final defaultFillColor = widget.fillColor ?? (isDark ? Colors.grey.shade800 : Colors.grey.shade50);

    final responsiveBorderRadius = widget.borderRadius.r;

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

    // Resolve suffix layout for toggler
    Widget? resolvedSuffix;
    if (widget.suffixWidget != null) {
      resolvedSuffix = widget.suffixWidget;
    } else if (widget.obscureText && widget.showPasswordToggle) {
      resolvedSuffix = IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          size: 20.r,
          color: Colors.grey,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    } else if (widget.suffixIcon != null) {
      resolvedSuffix = Icon(widget.suffixIcon, size: 22.r);
    }

    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      focusNode: widget.focusNode,
      validator: widget.validator,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      readOnly: widget.readOnly,
      autofocus: widget.autoFocus,
      maxLines: widget.obscureText ? 1 : widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      inputFormatters: widget.inputFormatters,
      textAlign: widget.textAlign,
      textCapitalization: widget.textCapitalization,
      autocorrect: widget.autocorrect,
      enableSuggestions: widget.enableSuggestions,
      autofillHints: widget.autofillHints,
      style: (widget.textStyle ?? theme.textTheme.bodyLarge)?.copyWith(
        fontSize: (widget.textStyle?.fontSize ?? theme.textTheme.bodyLarge?.fontSize ?? 16).sp,
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: (widget.labelStyle ?? theme.textTheme.bodyMedium)?.copyWith(
          color: Colors.grey.shade600,
          fontSize: (widget.labelStyle?.fontSize ?? theme.textTheme.bodyMedium?.fontSize ?? 14).sp,
        ),
        hintText: widget.hint,
        hintStyle: (widget.hintStyle ?? theme.textTheme.bodyMedium)?.copyWith(
          color: Colors.grey.shade500,
          fontSize: (widget.hintStyle?.fontSize ?? theme.textTheme.bodyMedium?.fontSize ?? 14).sp,
        ),
        errorStyle: widget.errorStyle?.copyWith(
          fontSize: (widget.errorStyle?.fontSize ?? 12).sp,
        ),
        filled: widget.filled,
        fillColor: defaultFillColor,
        contentPadding: widget.contentPadding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        prefixIcon: widget.prefixWidget ?? (widget.prefixIcon != null ? Icon(widget.prefixIcon, size: 22.r) : null),
        suffixIcon: resolvedSuffix,
        border: border,
        enabledBorder: border,
        focusedBorder: focusBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
      ),
    );
  }
}
