import 'package:get/get.dart';
import 'package:getx_template/utils/app_log/app_log.dart';
import 'package:getx_template/utils/constants/storage_keys.dart';
import 'package:getx_template/core/routing/app_routes.dart';
import 'package:getx_template/services/storage/shared_preferences_service.dart';
import 'package:getx_template/shared/controllers/base_controller.dart';

class SplashController extends BaseController {
  @override
  void onReady() {
    super.onReady();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await Future<void>.delayed(
      const Duration(milliseconds: 900),
    );
    final storage = Get.find<SharedPreferencesService>();

    final user = storage.getUser();
    final seenOnboarding =
        storage.getBool(StorageKeys.onboardingSeen) ??
        false;

    AppLog.cache(
      "User token: ${user?.token}, Seen onboarding: $seenOnboarding",
      source: "Splash Screen",
    );

    if (user?.token != null) {
      AppLog.info(
        "Navigating to Home",
        source: "Splash Screen",
      );
      Get.offAllNamed(AppRoutes.home);
    } else if (!seenOnboarding) {
      Get.offAllNamed(AppRoutes.onboarding);
    } else {
      Get.offAllNamed(AppRoutes.authWelcome);
    }
  }
}
