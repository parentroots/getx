import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/routes/app_routes.dart';
import 'package:getx_template/shared/controllers/base_controller.dart';

class AuthController extends BaseController {
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  final forgotPasswordFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final otpController = TextEditingController();
  final RxBool obscurePassword = true.obs;

  void togglePasswordVisibility() => obscurePassword.toggle();

  void submitLogin() => _validate(loginFormKey, AppRoutes.home);
  void submitRegister() => _validate(registerFormKey, AppRoutes.home);
  void submitForgotPassword() =>
      _validate(forgotPasswordFormKey, AppRoutes.otpVerification);
  void verifyOtp() => _validate(otpFormKey, AppRoutes.login);

  void _validate(GlobalKey<FormState> key, String nextRoute) {
    if (key.currentState?.validate() ?? false) {
      Get.offAllNamed(nextRoute);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    otpController.dispose();
    super.onClose();
  }
}
