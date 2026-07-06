import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/utils/constants/storage_keys.dart';
import 'package:getx_template/core/routing/app_routes.dart';
import 'package:getx_template/services/storage/shared_preferences_service.dart';
import 'package:getx_template/shared/controllers/base_controller.dart';

class OnboardingController extends BaseController {
  final PageController pageController = PageController();
  final RxInt currentIndex = 0.obs;

  void updateIndex(int index) {
    currentIndex.value = index;
  }

  void nextPage() {
    if (currentIndex.value < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      finish();
    }
  }

  Future<void> finish() async {
    await Get.find<SharedPreferencesService>().setBool(
      StorageKeys.onboardingSeen,
      true,
    );  
    Get.offAllNamed(AppRoutes.authWelcome);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
