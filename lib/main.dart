import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/app/app.dart';
import 'package:getx_template/app/app_config.dart';
import 'package:getx_template/core/errors/global_error_handler.dart';
import 'package:getx_template/services/firebase/firebase_service.dart';
import 'package:getx_template/services/storage/shared_preferences_service.dart';

Future<void> main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      FlutterError.onError = GlobalErrorHandler.onFlutterError;
      PlatformDispatcher.instance.onError = GlobalErrorHandler.onPlatformError;

      await SharedPreferencesService.init();
      await FirebaseService.init();

      runApp(const StarterApp(config: AppConfig()));
    },
    (error, stackTrace) {
      GlobalErrorHandler.record(error, stackTrace);
      if (Get.isRegistered<GlobalErrorHandler>()) {
        Get.find<GlobalErrorHandler>().showError(error);
      }
    },
  );
}
