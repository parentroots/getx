import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/dialogs/common_snackbar.dart';
import 'package:getx_template/core/routing/app_routes.dart';
import 'package:getx_template/data/models/user_model.dart';
import 'package:getx_template/data/repositories/auth_repository.dart';
import 'package:getx_template/services/storage/shared_preferences_service.dart';
import 'package:getx_template/shared/controllers/base_controller.dart';

class AuthController extends BaseController {
  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final SharedPreferencesService _storage = Get.find<SharedPreferencesService>();

  // Global Keys for Forms validation
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  final forgotPasswordFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();
  final changePasswordFormKey = GlobalKey<FormState>();

  // Controllers for text input fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final otpController = TextEditingController();

  final currentPasswordTEController = TextEditingController();
  final newPasswordTEController = TextEditingController();
  final confirmNewPasswordTEController = TextEditingController();

  // Remember me switch state
  final RxBool isSwitchOn = false.obs;

  /// Submit Login credentials to API
  Future<void> submitLogin() async {
    final isValid = loginFormKey.currentState?.validate() ?? false;
    if (!isValid) return;

    try {
      isLoading.value = true;

      // 1. Perform login API call
      final responseData = await _authRepository.login(
        emailController.text.trim(),
        passwordController.text,
      );

      // 2. Parse user from API response
      final user = UserModel.fromJson((responseData['data'] ?? responseData) as Map<String, dynamic>);

      // 3. Save user info locally
      await _storage.saveUser(user);

      // 4. Navigate to Home
      Get.offAllNamed(AppRoutes.mainBottomNavScreen);
    } catch (error) {
      CommonSnackbar.showError(title: 'Error', message: error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Submit Registration details to API
  Future<void> submitRegister() async {
    final isValid = registerFormKey.currentState?.validate() ?? false;
    if (!isValid) return;

    try {
      isLoading.value = true;

      // 1. Perform registration API call
      final responseData = await _authRepository.register(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      // 2. Parse user from API response
      final user = UserModel.fromJson((responseData['data'] ?? responseData) as Map<String, dynamic>);

      // 3. Save user info locally
      await _storage.saveUser(user);

      // 4. Navigate to Home
      Get.offAllNamed(AppRoutes.mainBottomNavScreen);
    } catch (error) {
      CommonSnackbar.showError(title: 'Error', message: error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Change Password API call
  Future<void> changePassword() async {
    final isValid = changePasswordFormKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (newPasswordTEController.text.trim() !=
        confirmNewPasswordTEController.text.trim()) {
      CommonSnackbar.showError(
        title: "Validation Error",
        message: "Password Doesn't match",
      );
      return;
    }

    try {
      isLoading.value = true;

      // 1. Perform change password API call
      await _authRepository.changePassword(
        currentPassword: currentPasswordTEController.text,
        newPassword: newPasswordTEController.text,
      );

      CommonSnackbar.showSuccess(
        title: "Success",
        message: "Password changed successfully",
      );

      // 2. Clear password input fields
      currentPasswordTEController.clear();
      newPasswordTEController.clear();
      confirmNewPasswordTEController.clear();

      Get.back();
    } catch (error) {
      CommonSnackbar.showError(title: "Error", message: error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Submit Forgot Password
  void submitForgotPassword() {
    final isValid = forgotPasswordFormKey.currentState?.validate() ?? false;
    if (isValid) {
      Get.offAllNamed(AppRoutes.otpVerification);
    }
  }

  /// Verify OTP
  void verifyOtp() {
    final isValid = otpFormKey.currentState?.validate() ?? false;
    if (isValid) {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    otpController.dispose();
    currentPasswordTEController.dispose();
    newPasswordTEController.dispose();
    confirmNewPasswordTEController.dispose();
    super.onClose();
  }
}
