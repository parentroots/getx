import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/shared/controllers/base_controller.dart';

class ProfileController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  void saveProfile() {
    if (formKey.currentState?.validate() ?? false) {
      Get.back<void>();
      Get.snackbar(
        'Saved',
        'Profile changes are ready to connect to your backend.',
      );
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
