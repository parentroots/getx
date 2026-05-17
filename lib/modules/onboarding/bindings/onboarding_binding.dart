import 'package:get/get.dart';
import 'package:getx_template/modules/onboarding/controllers/onboarding_controller.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(OnboardingController.new);
  }
}
