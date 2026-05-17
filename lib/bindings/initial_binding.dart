import 'package:get/get.dart';
import 'package:getx_template/app/app_config.dart';
import 'package:getx_template/app/app_lifecycle_observer.dart';
import 'package:getx_template/core/errors/global_error_handler.dart';
import 'package:getx_template/core/network/api_client.dart';
import 'package:getx_template/core/network/network_info.dart';
import 'package:getx_template/core/network/token_manager.dart';
import 'package:getx_template/services/connectivity/connectivity_service.dart';
import 'package:getx_template/services/dialog/dialog_service.dart';
import 'package:getx_template/services/notification/notification_service.dart';
import 'package:getx_template/services/storage/secure_storage_service.dart';
import 'package:getx_template/services/storage/shared_preferences_service.dart';

class InitialBinding extends Bindings {
  InitialBinding({required this.config});

  final AppConfig config;

  @override
  void dependencies() {
    Get.put<AppConfig>(config, permanent: true);
    Get.put<DialogService>(DialogService(), permanent: true);
    Get.put<GlobalErrorHandler>(GlobalErrorHandler(), permanent: true);
    Get.put<SharedPreferencesService>(
      SharedPreferencesService.instance,
      permanent: true,
    );
    Get.put<SecureStorageService>(SecureStorageService(), permanent: true);
    Get.put<TokenManager>(TokenManager(Get.find()), permanent: true);
    Get.put<ConnectivityService>(ConnectivityService(), permanent: true);
    Get.put<NetworkInfo>(NetworkInfo(Get.find()), permanent: true);
    Get.put<ApiClient>(
      ApiClient(config: config, tokenManager: Get.find()),
      permanent: true,
    );
    Get.putAsync<NotificationService>(
      () => NotificationService().init(),
      permanent: true,
    );
    Get.putAsync<AppLifecycleObserver>(() => AppLifecycleObserver().init());
  }
}
