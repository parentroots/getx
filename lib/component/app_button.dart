import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_template/component/layout/app_text.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    this.label,
    this.child,
    this.icon,
    this.iconRight,
    this.isLoading = false,
    this.isOutlined = false,
    this.isTextButton = false,
    this.width,
    this.height = 50.0,
    this.backgroundColor,
    this.foregroundColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.borderColor,
    this.textStyle,
    this.padding,
    this.borderRadius = 12.0,
    this.elevation,
  }) : assert(label != null || child != null, 'Either label or child must be provided.');

  final String? label;
  final Widget? child;
  final VoidCallback? onPressed;
  final Widget? icon;
  final Widget? iconRight;
  final bool isLoading;
  final bool isOutlined;
  final bool isTextButton;
  
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEnabled = onPressed != null && !isLoading;

    final defaultBackground = backgroundColor ?? theme.primaryColor;
    final defaultForeground = foregroundColor ?? Colors.white;

    final responsiveHeight = height.h;
    final responsiveWidth = width?.w;
    final responsiveBorderRadius = borderRadius.r;

    final content = isLoading
        ? SizedBox.square(
            dimension: 24.r,
            child: CircularProgressIndicator(
              strokeWidth: 2.5.r,
              valueColor: AlwaysStoppedAnimation<Color>(
                isOutlined || isTextButton ? defaultBackground : defaultForeground,
              ),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                icon!,
                SizedBox(width: 8.w),
              ],
              if (child != null) 
                child! 
              else 
                Flexible(
                  child: AppText(
                    label!,
                    variant: TextVariant.title,
                    weight: textStyle?.fontWeight == FontWeight.bold ? TextWeight.bold : TextWeight.medium,
                    color: isOutlined || isTextButton ? defaultBackground : defaultForeground,
                    fontSize: textStyle?.fontSize,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              if (iconRight != null) ...[
                SizedBox(width: 8.w),
                iconRight!,
              ],
            ],
          );

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(responsiveBorderRadius),
      side: isOutlined
          ? BorderSide(color: borderColor ?? defaultBackground, width: 1.r)
          : BorderSide.none,
    );

    Widget button;

    if (isTextButton) {
      button = TextButton(
        onPressed: isEnabled ? onPressed : null,
        style: TextButton.styleFrom(
          foregroundColor: defaultBackground,
          disabledForegroundColor: disabledForegroundColor ?? Colors.grey,
          padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          shape: shape,
          minimumSize: Size(responsiveWidth ?? 0, responsiveHeight),
        ),
        child: content,
      );
    } else if (isOutlined) {
      button = OutlinedButton(
        onPressed: isEnabled ? onPressed : null,
        style: OutlinedButton.styleFrom(
          foregroundColor: defaultBackground,
          disabledForegroundColor: disabledForegroundColor ?? Colors.grey,
          padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          shape: shape,
          minimumSize: Size(responsiveWidth ?? 0, responsiveHeight),
        ),
        child: content,
      );
    } else {
      button = ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: defaultBackground,
          foregroundColor: defaultForeground,
          disabledBackgroundColor: disabledBackgroundColor ?? Colors.grey.shade300,
          disabledForegroundColor: disabledForegroundColor ?? Colors.grey.shade600,
          padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          shape: shape,
          elevation: elevation ?? 0,
          minimumSize: Size(responsiveWidth ?? 0, responsiveHeight),
        ),
        child: content,
      );
    }

    if (width != null) {
      return SizedBox(
        width: responsiveWidth,
        height: responsiveHeight,
        child: button,
      );
    }

    return button;
  }
}
