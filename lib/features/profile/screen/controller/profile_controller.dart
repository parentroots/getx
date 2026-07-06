import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/core/routing/app_routes.dart';
import 'package:getx_template/data/models/user_model.dart';
import 'package:getx_template/services/storage/shared_preferences_service.dart';
import 'package:getx_template/shared/controllers/base_controller.dart';

class ProfileController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  final SharedPreferencesService _storage =Get.find<SharedPreferencesService>();

  final Rxn<UserModel> rxUser = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    final user = _storage.getUser();
    rxUser.value = user;
    if (user != null) {
      nameController.text = user.name ?? '';
      emailController.text = user.email ?? '';
    }
  }

  void saveProfile() {
    if (formKey.currentState?.validate() ?? false) {
      final currentUser = rxUser.value ?? UserModel();
      final updatedUser = currentUser.copyWith(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
      );

      _storage.saveUser(updatedUser);
      rxUser.value = updatedUser;

      Get.back<void>();
      Get.snackbar(
        'Success',
        'Profile changes updated in Local Storage.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
  }

  void logout() {
    _storage.clearUser();
    rxUser.value = null;
    Get.offAllNamed(AppRoutes.login);
    Get.snackbar(
      'Logged Out',
      'You have been logged out successfully.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
