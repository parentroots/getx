import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/app.dart';
import 'package:getx_template/core/config/app_config.dart';
import 'package:getx_template/utils/errors/global_error_handler.dart';
import 'package:getx_template/core/network/api_client.dart';
import 'package:getx_template/core/network/socket_client.dart';
import 'package:getx_template/core/network/token_manager.dart';
import 'package:getx_template/services/firebase/firebase_service.dart';
import 'package:getx_template/services/storage/secure_storage_service.dart';
import 'package:getx_template/services/storage/shared_preferences_service.dart';

Future<void> main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      FlutterError.onError = GlobalErrorHandler.onFlutterError;
      PlatformDispatcher.instance.onError = GlobalErrorHandler.onPlatformError;

      await SharedPreferencesService.init();
      await FirebaseService.init();

      const appConfig = AppConfig();
      final secureStorage = SecureStorageService();
      final tokenManager = TokenManager(secureStorage);

      // Initialize Global Network Clients
      ApiClient.instance.init(config: appConfig, tokenManager: tokenManager);

      // Initialize Global Socket Client (connect to a base URL or specific endpoint)
      SocketClient.instance.init(url: appConfig.apiBaseUrl);

      runApp(const StarterApp(config: appConfig));
    },
    (error, stackTrace) {
      GlobalErrorHandler.record(error, stackTrace);
      if (Get.isRegistered<GlobalErrorHandler>()) {
        Get.find<GlobalErrorHandler>().showError(error);
      }
    },
  );
}
