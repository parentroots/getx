import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/layout/common_text.dart';

enum SnackbarType { success, error, warning, info }

class CommonSnackbar {
  /// Shows a custom glassmorphic snackbar with frosted backdrop blur and glow effect.
  static void show({
    required String title,
    required String message,
    SnackbarType type = SnackbarType.info,
    SnackPosition position = SnackPosition.TOP,
    Duration duration = const Duration(seconds: 3),
    Widget? icon,
    bool isDismissible = true,
  }) {
    final context = Get.context;
    if (context == null) return;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color backgroundColor;
    Color indicatorColor;
    Color titleTextColor;
    Color messageTextColor;
    IconData defaultIcon;

    // Theming configurations with modern Tailwind-style accent details
    switch (type) {
      case SnackbarType.success:
        backgroundColor = isDark 
            ? const Color(0xFF064E3B).withValues(alpha: 0.65)
            : const Color(0xFFECFDF5).withValues(alpha: 0.75);
        indicatorColor = const Color(0xFF10B981);
        titleTextColor = isDark ? Colors.white : const Color(0xFF065F46);
        messageTextColor = isDark ? Colors.grey.shade300 : const Color(0xFF047857);
        defaultIcon = Icons.check_circle_rounded;
        break;
      case SnackbarType.error:
        backgroundColor = isDark 
            ? const Color(0xFF7F1D1D).withValues(alpha: 0.65)
            : const Color(0xFFFEF2F2).withValues(alpha: 0.75);
        indicatorColor = const Color(0xFFEF4444);
        titleTextColor = isDark ? Colors.white : const Color(0xFF991B1B);
        messageTextColor = isDark ? Colors.grey.shade300 : const Color(0xFFB91C1C);
        defaultIcon = Icons.error_rounded;
        break;
      case SnackbarType.warning:
        backgroundColor = isDark 
            ? const Color(0xFF78350F).withValues(alpha: 0.65)
            : const Color(0xFFFFFBEB).withValues(alpha: 0.75);
        indicatorColor = const Color(0xFFF59E0B);
        titleTextColor = isDark ? Colors.white : const Color(0xFF92400E);
        messageTextColor = isDark ? Colors.grey.shade300 : const Color(0xFFB45309);
        defaultIcon = Icons.warning_rounded;
        break;
      case SnackbarType.info:
      default:
        backgroundColor = isDark 
            ? const Color(0xFF0C4A6E).withValues(alpha: 0.65)
            : const Color(0xFFF0F9FF).withValues(alpha: 0.75);
        indicatorColor = const Color(0xFF0EA5E9);
        titleTextColor = isDark ? Colors.white : const Color(0xFF075985);
        messageTextColor = isDark ? Colors.grey.shade300 : const Color(0xFF0369A1);
        defaultIcon = Icons.info_rounded;
        break;
    }

    final thinBorderColor = isDark 
        ? Colors.grey.shade800.withValues(alpha: 0.4)
        : Colors.grey.shade200.withValues(alpha: 0.8);
        
    final shadowGlowColor = indicatorColor.withValues(alpha:  isDark ? 0.2 : 0.08);
    final iconBgColor = indicatorColor.withValues(alpha:  isDark ? 0.2 : 0.1);

    Get.rawSnackbar(
      snackPosition: position,
      duration: duration,
      backgroundColor: Colors.transparent,

      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      padding: EdgeInsets.zero,
      isDismissible: isDismissible,
      animationDuration: const Duration(milliseconds: 450),
      forwardAnimationCurve: Curves.easeOutBack, // physical spring-like bounce!
      reverseAnimationCurve: Curves.fastOutSlowIn,
      messageText: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: shadowGlowColor,
              blurRadius: 16.r,
              spreadRadius: 2.r,
              offset: Offset(0, 4.h),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha:  isDark ? 0.3 : 0.05),
              blurRadius: 24.r,
              spreadRadius: 0,
              offset: Offset(0, 8.h),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: thinBorderColor,
                  width: 1.r,
                ),
              ),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Left vertical indicator bar
                    Container(
                      width: 6.w,
                      decoration: BoxDecoration(
                        color: indicatorColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          bottomLeft: Radius.circular(16.r),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    
                    // Circular Icon Badge
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: iconBgColor,
                          ),
                          child: icon ?? Icon(
                            defaultIcon,
                            color: indicatorColor,
                            size: 20.r,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    
                    // Text details
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 12.h, bottom: 12.h, right: 16.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonText(
                              title,
                              variant: TextVariant.body,
                              weight: TextWeight.bold,
                              color: titleTextColor,
                            ),
                            SizedBox(height: 3.h),
                            CommonText(
                              message,
                              variant: TextVariant.caption,
                              color: messageTextColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Convenience method for Success Snackbar
  static void showSuccess({required String title, required String message}) {
    show(title: title, message: message, type: SnackbarType.success);
  }

  /// Convenience method for Error Snackbar
  static void showError({required String title, required String message}) {
    show(title: title, message: message, type: SnackbarType.error);
  }

  /// Convenience method for Warning Snackbar
  static void showWarning({required String title, required String message}) {
    show(title: title, message: message, type: SnackbarType.warning);
  }

  /// Convenience method for Info Snackbar
  static void showInfo({required String title, required String message}) {
    show(title: title, message: message, type: SnackbarType.info);
  }
}
