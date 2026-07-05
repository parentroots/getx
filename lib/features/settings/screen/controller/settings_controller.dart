import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/utils/constants/storage_keys.dart';
import 'package:getx_template/services/storage/shared_preferences_service.dart';
import 'package:getx_template/shared/controllers/base_controller.dart';

class SettingsController extends BaseController {
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  void setThemeMode(ThemeMode mode) {
    themeMode.value = mode;
    Get.changeThemeMode(mode);
    Get.find<SharedPreferencesService>().setString(
      StorageKeys.themeMode,
      mode.name,
    );
  }
}
