import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/core/errors/app_exception.dart';
import 'package:getx_template/core/utils/helper/app_log.dart';
import 'package:getx_template/services/dialog/dialog_service.dart';

class GlobalErrorHandler extends GetxService {
  static void onFlutterError(FlutterErrorDetails details) {
    FlutterError.presentError(details);
    record(details.exception, details.stack);
  }

  static bool onPlatformError(Object error, StackTrace stackTrace) {
    record(error, stackTrace);
    return true;
  }

  static void record(Object error, StackTrace? stackTrace) {
    AppLog.error(error.toString(), error: error, stackTrace: stackTrace);
  }

  void showError(Object error) {
    final message = error is AppException
        ? error.message
        : 'Something went wrong. Please try again.';
    if (Get.isRegistered<DialogService>()) {
      Get.find<DialogService>().showError(message: message);
    } else {
      Get.snackbar('Error', message, snackPosition: SnackPosition.BOTTOM);
    }
  }
}
