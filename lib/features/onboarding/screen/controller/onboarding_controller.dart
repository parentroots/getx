import 'package:get/get.dart';
import 'package:getx_template/core/constants/storage_keys.dart';
import 'package:getx_template/core/routing/app_routes.dart';
import 'package:getx_template/services/storage/shared_preferences_service.dart';
import 'package:getx_template/shared/controllers/base_controller.dart';

class OnboardingController extends BaseController {
  final RxInt currentIndex = 0.obs;

  Future<void> finish() async {
    await Get.find<SharedPreferencesService>().setBool(
      StorageKeys.onboardingSeen,
      true,
    );
    Get.offAllNamed(AppRoutes.authWelcome);
  }
}
