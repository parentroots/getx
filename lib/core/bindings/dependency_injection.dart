import 'package:get/get.dart';
import 'package:getx_template/core/config/app_lifecycle_observer.dart';
import 'package:getx_template/data/repositories/auth_repository.dart';
import 'package:getx_template/features/auth/screen/controller/auth_controller.dart';
import 'package:getx_template/features/home/screen/controller/home_controller.dart';
import 'package:getx_template/features/notifications/screen/controller/notifications_controller.dart';
import 'package:getx_template/features/onboarding/screen/controller/onboarding_controller.dart';
import 'package:getx_template/features/profile/screen/controller/profile_controller.dart';
import 'package:getx_template/features/settings/screen/controller/settings_controller.dart';
import 'package:getx_template/features/splash/screen/controller/splash_controller.dart';
import 'package:getx_template/features/system/screen/controller/system_controller.dart';
import 'package:getx_template/services/storage/shared_preferences_service.dart';
import 'package:getx_template/services/connectivity/connectivity_service.dart';
import 'package:getx_template/services/dialog/dialog_service.dart';
import 'package:getx_template/services/notification/notification_service.dart';
import 'package:getx_template/utils/errors/global_error_handler.dart';
import 'package:getx_template/component/main_bottom_nav/main_bottom_nav_controller.dart';

class DependencyInjection extends Bindings {
  @override
  void dependencies() {
    Get.putAsync(() => AppLifecycleObserver().init());
    
    // Services
    Get.lazyPut(() => SharedPreferencesService.instance, fenix: true);
    Get.put(ConnectivityService(), permanent: true);
    Get.put(DialogService(), permanent: true);
    Get.putAsync(() => NotificationService().init());
    Get.put(GlobalErrorHandler(), permanent: true);


    // Repositories
    Get.lazyPut(() => AuthRepository(), fenix: true);



    // Controllers
    Get.lazyPut(() => MainBottomNavController(), fenix: true);
    Get.lazyPut(() => SplashController(), fenix: true);
    Get.lazyPut(() => OnboardingController(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => HomeController(), fenix: true);
    Get.lazyPut(() => NotificationsController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => SettingsController(), fenix: true);
    Get.lazyPut(() => SystemController(), fenix: true);
  }
}
