import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/button/common_button.dart';
import 'package:getx_template/component/layout/common_text.dart';
import 'package:getx_template/utils/constants/app_colors.dart';

enum DialogType {
  success,
  error,
  warning,
  info,
  confirmation,
}

class CommonDialog extends StatelessWidget {
  const CommonDialog({
    super.key,
    required this.title,
    required this.subtitle,
    this.type = DialogType.confirmation,
    this.image,
    this.icon,
    this.iconColor,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.onPrimaryTap,
    this.onSecondaryTap,
    this.onClose,
    this.showCloseButton = true,
    this.titleFontSize = 20,
    this.subtitleFontSize = 14,
    this.titleColor,
    this.subtitleColor,
    this.titleFontWeight = FontWeight.w600,
    this.subtitleFontWeight = FontWeight.w400,
    this.imageHeight = 120,
    this.imageWidth = 120,
    this.primaryButtonColor,
    this.secondaryButtonColor,
  });

  final String title;
  final String subtitle;
  final DialogType type;
  final String? image;
  final IconData? icon;
  final Color? iconColor;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final VoidCallback? onPrimaryTap;
  final VoidCallback? onSecondaryTap;
  final VoidCallback? onClose;
  final bool showCloseButton;

  final double titleFontSize;
  final Color? titleColor;
  final FontWeight titleFontWeight;

  final double subtitleFontSize;
  final Color? subtitleColor;
  final FontWeight subtitleFontWeight;
  final double imageHeight;
  final double imageWidth;

  final Color? primaryButtonColor;
  final Color? secondaryButtonColor;

  // Static Helpers ========================================================
  
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String subtitle,
    DialogType type = DialogType.confirmation,
    String? image,
    IconData? icon,
    Color? iconColor,
    String? primaryButtonText,
    String? secondaryButtonText,
    VoidCallback? onPrimaryTap,
    VoidCallback? onSecondaryTap,
    VoidCallback? onClose,
    bool showCloseButton = true,
    double titleFontSize = 20,
    double subtitleFontSize = 14,
    Color? titleColor,
    Color? subtitleColor,
    FontWeight titleFontWeight = FontWeight.w600,
    FontWeight subtitleFontWeight = FontWeight.w400,
    double imageHeight = 120,
    double imageWidth = 120,
    Color? primaryButtonColor,
    Color? secondaryButtonColor,
    bool barrierDismissible = false,
  }) {
    return Get.dialog<bool>(
      CommonDialog(
        title: title,
        subtitle: subtitle,
        type: type,
        image: image,
        icon: icon,
        iconColor: iconColor,
        primaryButtonText: primaryButtonText,
        secondaryButtonText: secondaryButtonText,
        onPrimaryTap: onPrimaryTap,
        onSecondaryTap: onSecondaryTap,
        onClose: onClose,
        showCloseButton: showCloseButton,
        titleFontSize: titleFontSize,
        subtitleFontSize: subtitleFontSize,
        titleColor: titleColor,
        subtitleColor: subtitleColor,
        titleFontWeight: titleFontWeight,
        subtitleFontWeight: subtitleFontWeight,
        imageHeight: imageHeight,
        imageWidth: imageWidth,
        primaryButtonColor: primaryButtonColor,
        secondaryButtonColor: secondaryButtonColor,
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static Future<bool?> showSuccess({
    required BuildContext context,
    required String title,
    required String subtitle,
    String? primaryButtonText = 'OK',
    VoidCallback? onPrimaryTap,
    bool showCloseButton = true,
    bool barrierDismissible = false,
  }) {
    return show(
      context,
      title: title,
      subtitle: subtitle,
      type: DialogType.success,
      primaryButtonText: primaryButtonText,
      onPrimaryTap: onPrimaryTap,
      showCloseButton: showCloseButton,
      barrierDismissible: barrierDismissible,
    );
  }

  static Future<bool?> showError({
    required BuildContext context,
    required String title,
    required String subtitle,
    String? primaryButtonText = 'OK',
    VoidCallback? onPrimaryTap,
    bool showCloseButton = true,
    bool barrierDismissible = false,
  }) {
    return show(
      context,
      title: title,
      subtitle: subtitle,
      type: DialogType.error,
      primaryButtonText: primaryButtonText,
      onPrimaryTap: onPrimaryTap,
      showCloseButton: showCloseButton,
      barrierDismissible: barrierDismissible,
    );
  }

  static Future<bool?> showWarning({
    required BuildContext context,
    required String title,
    required String subtitle,
    String? primaryButtonText = 'Confirm',
    String? secondaryButtonText = 'Cancel',
    VoidCallback? onPrimaryTap,
    VoidCallback? onSecondaryTap,
    bool showCloseButton = true,
    bool barrierDismissible = false,
  }) {
    return show(
      context,
      title: title,
      subtitle: subtitle,
      type: DialogType.warning,
      primaryButtonText: primaryButtonText,
      secondaryButtonText: secondaryButtonText,
      onPrimaryTap: onPrimaryTap,
      onSecondaryTap: onSecondaryTap,
      showCloseButton: showCloseButton,
      barrierDismissible: barrierDismissible,
    );
  }

  static Future<bool?> showInfo({
    required BuildContext context,
    required String title,
    required String subtitle,
    String? primaryButtonText = 'OK',
    VoidCallback? onPrimaryTap,
    bool showCloseButton = true,
    bool barrierDismissible = true,
  }) {
    return show(
      context,
      title: title,
      subtitle: subtitle,
      type: DialogType.info,
      primaryButtonText: primaryButtonText,
      onPrimaryTap: onPrimaryTap,
      showCloseButton: showCloseButton,
      barrierDismissible: barrierDismissible,
    );
  }

  static Future<bool?> showConfirmation({
    required BuildContext context,
    required String title,
    required String subtitle,
    String? primaryButtonText = 'Confirm',
    String? secondaryButtonText = 'Cancel',
    VoidCallback? onPrimaryTap,
    VoidCallback? onSecondaryTap,
    bool showCloseButton = true,
    bool barrierDismissible = false,
  }) {
    return show(
      context,
      title: title,
      subtitle: subtitle,
      type: DialogType.confirmation,
      primaryButtonText: primaryButtonText,
      secondaryButtonText: secondaryButtonText,
      onPrimaryTap: onPrimaryTap,
      onSecondaryTap: onSecondaryTap,
      showCloseButton: showCloseButton,
      barrierDismissible: barrierDismissible,
    );
  }

  // Builder Methods =======================================================

  Color _getAccentColor() {
    switch (type) {
      case DialogType.success:
        return AppColors.success;
      case DialogType.error:
        return AppColors.error;
      case DialogType.warning:
        return AppColors.warning;
      case DialogType.info:
        return AppColors.info;
      case DialogType.confirmation:
        return AppColors.primary;
    }
  }

  Widget _buildIconHeader(BuildContext context, bool isDark) {
    if (image != null) {
      return Image.asset(
        image!,
        height: imageHeight.h,
        width: imageWidth.w,
        fit: BoxFit.contain,
      );
    }

    final Color accentColor = _getAccentColor();
    IconData iconData;
    switch (type) {
      case DialogType.success:
        iconData = icon ?? Icons.check_circle_rounded;
        break;
      case DialogType.error:
        iconData = icon ?? Icons.error_outline_rounded;
        break;
      case DialogType.warning:
        iconData = icon ?? Icons.warning_amber_rounded;
        break;
      case DialogType.info:
        iconData = icon ?? Icons.info_outline_rounded;
        break;
      case DialogType.confirmation:
        iconData = icon ?? Icons.help_outline_rounded;
        break;
    }

    final Color finalIconColor = iconColor ?? accentColor;

    return Container(
      width: 80.w,
      height: 80.w,
      decoration: BoxDecoration(
        color: finalIconColor.withValues(alpha: 0.12),
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        size: 40.sp,
        color: finalIconColor,
      ),
    );
  }

  Widget _buildButtons(BuildContext context, Color accentColor, bool isDark) {
    final bool hasTwoButtons =
        primaryButtonText != null && secondaryButtonText != null;

    if (hasTwoButtons) {
      final Color resolvedPrimaryColor = primaryButtonColor ?? accentColor;
      final Color resolvedSecondaryColor = secondaryButtonColor ?? accentColor;

      return Row(
        children: [
          Expanded(
            child: CommonButton(
              titleText: primaryButtonText!,
              titleSize: 13,
              buttonHeight: 46.h,
              buttonColor: resolvedPrimaryColor,
              onTap: onPrimaryTap ?? () => Get.back(result: true),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: CommonButton(
              titleText: secondaryButtonText!,
              titleSize: 13,
              buttonHeight: 46.h,
              buttonColor: isDark ? Colors.transparent : Colors.white,
              titleColor: resolvedSecondaryColor,
              borderColor: resolvedSecondaryColor,
              border: true,
              onTap: onSecondaryTap ?? () => Get.back(result: false),
            ),
          ),
        ],
      );
    } else {
      final String btnText = primaryButtonText ?? secondaryButtonText ?? 'OK';
      final Color btnColor = primaryButtonColor ?? accentColor;

      return CommonButton(
        buttonWidth: double.maxFinite,
        titleText: btnText,
        titleSize: 14,
        buttonHeight: 48.h,
        buttonColor: btnColor,
        onTap: onPrimaryTap ?? onSecondaryTap ?? () => Get.back(result: true),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final Color resolvedBg = theme.colorScheme.surface;
    final Color accentColor = _getAccentColor();

    return Dialog(
      backgroundColor: resolvedBg,
      elevation: 6,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Container(
        constraints: BoxConstraints(maxWidth: 340.w),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Main Content
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 28.h, 20.w, 24.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildIconHeader(context, isDark),
                  SizedBox(height: 20.h),
                  CommonText(
                    title,
                    textAlign: TextAlign.center,
                    fontSize: titleFontSize,
                    weight: TextWeight.bold,
                    color: titleColor ?? theme.colorScheme.onSurface,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10.h),
                  CommonText(
                    subtitle,
                    textAlign: TextAlign.center,
                    fontSize: subtitleFontSize,
                    weight: TextWeight.regular,
                    color: subtitleColor ?? theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 24.h),
                  _buildButtons(context, accentColor, isDark),
                ],
              ),
            ),
            // Close Button
            if (showCloseButton)
              Positioned(
                top: 12.h,
                right: 12.w,
                child: GestureDetector(
                  onTap: onClose ?? () => Get.back(result: false),
                  child: Container(
                    width: 28.w,
                    height: 28.w,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.05),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      size: 16.sp,
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
