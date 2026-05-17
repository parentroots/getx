import 'package:get/get.dart';
import 'package:getx_template/core/constants/storage_keys.dart';
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
    await Future<void>.delayed(const Duration(milliseconds: 900));
    final seenOnboarding =
        Get.find<SharedPreferencesService>().getBool(
          StorageKeys.onboardingSeen,
        ) ??
        false;
    Get.offAllNamed(
      seenOnboarding ? AppRoutes.authWelcome : AppRoutes.onboarding,
    );
  }
}
