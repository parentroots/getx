import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/dialogs/common_dialog.dart';
import 'package:getx_template/component/dialogs/loading_dialog.dart';

class DialogService extends GetxService {
  void showSnack({
    required String title,
    required String message,
    SnackPosition position = SnackPosition.BOTTOM,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: position,
      margin: const EdgeInsets.all(16),
    );
  }

  Future<bool?> confirm({
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) {
    return CommonDialog.showConfirmation(
      context: Get.context ?? Get.overlayContext ?? Get.key.currentContext!,
      title: title,
      subtitle: message,
      primaryButtonText: confirmText,
      secondaryButtonText: cancelText,
    );
  }

  Future<bool?> showSuccess({
    required String title,
    required String message,
    String buttonText = 'OK',
  }) {
    return CommonDialog.showSuccess(
      context: Get.context ?? Get.overlayContext ?? Get.key.currentContext!,
      title: title,
      subtitle: message,
      primaryButtonText: buttonText,
    );
  }

  Future<bool?> showInfo({
    required String title,
    required String message,
    String buttonText = 'OK',
  }) {
    return CommonDialog.showInfo(
      context: Get.context ?? Get.overlayContext ?? Get.key.currentContext!,
      title: title,
      subtitle: message,
      primaryButtonText: buttonText,
    );
  }

  Future<bool?> showWarning({
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) {
    return CommonDialog.showWarning(
      context: Get.context ?? Get.overlayContext ?? Get.key.currentContext!,
      title: title,
      subtitle: message,
      primaryButtonText: confirmText,
      secondaryButtonText: cancelText,
    );
  }

  void showLoading({String message = 'Please wait...'}) {
    if (Get.isDialogOpen == true) return;
    Get.dialog<void>(
      LoadingDialog(message: message),
      barrierDismissible: false,
    );
  }

  void hideLoading() {
    if (Get.isDialogOpen == true) Get.back<void>();
  }

  void showError({required String message, String title = 'Error'}) {
    CommonDialog.showError(
      context: Get.context ?? Get.overlayContext ?? Get.key.currentContext!,
      title: title,
      subtitle: message,
      primaryButtonText: 'OK',
    );
  }

  Future<T?> showAppBottomSheet<T>(Widget child) {
    return Get.bottomSheet<T>(
      SafeArea(child: child),
      isScrollControlled: true,
      backgroundColor: Get.theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }
}

