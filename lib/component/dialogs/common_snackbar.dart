import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

enum SnackbarType { success, error, warning, info }

class CommonSnackbar {
  /// Shows a generic or custom snackbar
  static void show({
    required String title,
    required String message,
    SnackbarType type = SnackbarType.info,
    SnackPosition position = SnackPosition.TOP,
    Duration duration = const Duration(seconds: 3),
    Widget? icon,
    bool isDismissible = true,
  }) {
    Color backgroundColor;
    Color textColor = Colors.white;
    IconData defaultIcon;

    switch (type) {
      case SnackbarType.success:
        backgroundColor = Colors.green.shade600;
        defaultIcon = Icons.check_circle_outline;
        break;
      case SnackbarType.error:
        backgroundColor = Colors.red.shade600;
        defaultIcon = Icons.error_outline;
        break;
      case SnackbarType.warning:
        backgroundColor = Colors.orange.shade600;
        defaultIcon = Icons.warning_amber_rounded;
        break;
      case SnackbarType.info:
      default:
        backgroundColor = Colors.blue.shade600;
        defaultIcon = Icons.info_outline;
        break;
    }

    Get.snackbar(
      title,
      message,
      snackPosition: position,
      backgroundColor: backgroundColor.withOpacity(0.9),
      colorText: textColor,
      icon: icon ?? Icon(defaultIcon, color: textColor, size: 28.r),
      margin: EdgeInsets.all(16.r),
      borderRadius: 12.r,
      isDismissible: isDismissible,
      duration: duration,
      snackStyle: SnackStyle.FLOATING,
      boxShadows: [
        BoxShadow(
          color: backgroundColor.withOpacity(0.4),
          blurRadius: 10.r,
          offset: Offset(0, 4.h),
        )
      ],
      animationDuration: const Duration(milliseconds: 400),
      forwardAnimationCurve: Curves.easeOutCirc,
      reverseAnimationCurve: Curves.easeInCirc,
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
