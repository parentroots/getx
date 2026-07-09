import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/dialogs/common_snackbar.dart';
import 'package:getx_template/core/routing/app_routes.dart';
import 'package:getx_template/data/models/paginated_response.dart';
import 'package:getx_template/data/models/user_model.dart';
import 'package:getx_template/data/repositories/auth_repository.dart';
import 'package:getx_template/services/storage/shared_preferences_service.dart';
import 'package:getx_template/shared/controllers/base_controller.dart';
import 'package:getx_template/component/pickers/common_country_picker.dart';

class AuthController extends BaseController {

  final AuthRepository _authRepository = Get.find<AuthRepository>();
  final SharedPreferencesService _storage = Get.find<SharedPreferencesService>();

  List<String> tabList = ['All', 'new', 'old'];

  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  final forgotPasswordFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();
  final changePasswordFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final otpController = TextEditingController();


  final currentPasswordTEController = TextEditingController();
  final newPasswordTEController = TextEditingController();
  final confirmNewPasswordTEController = TextEditingController();


  final RxBool isSwitchOn = false.obs;
  final RxInt currentTabIndex = 0.obs;

  final phoneController = TextEditingController();
  final RxDouble appRating = 5.0.obs;
  final RxBool obscurePassword = true.obs;
  final Rxn<CountryModel> selectedCountry = Rxn<CountryModel>();
  final Rxn<DateTime> selectedDate = Rxn<DateTime>();
  final RxList<File> selectedImages = <File>[].obs;


  void togglePasswordVisibility() => obscurePassword.toggle();

  Future<void> submitLogin() async {
    debugPrint("--> [Login] submitLogin button clicked");
    final isValid = loginFormKey.currentState?.validate() ?? false;
    debugPrint("--> [Login] Form validation status: $isValid");
    if (isValid) {
      try {
        /* await runBusy(() => _authRepository.login(
          emailController.text.trim(),
          passwordController.text,
        )); */

        // Save mock user details locally
        final user = UserModel(
          id: '123',
          name: emailController.text.trim().split('@').first.capitalizeFirst,
          email: emailController.text.trim(),
          token: 'hello-i-am-dummy-jwt-token',
        );
        debugPrint("--> [Login] Saving User to Storage: ${user.toJson()}");

        await _storage.saveUser(user);

        debugPrint("--> [Login] Read back user from Storage: ${_storage.getUser()?.toJson()}");

        Get.offAllNamed(AppRoutes.mainBottomNavScreen);
      } catch (error) {
        CommonSnackbar.showError(
          title: 'Error',
          message: error.toString(),
        );
      }
    }
  }

  Future<void> submitRegister() async {
    debugPrint("--> [Register] submitRegister button clicked");
    final isValid = registerFormKey.currentState?.validate() ?? false;
    debugPrint("--> [Register] Form validation status: $isValid");
    if (isValid) {
      try {
        /* await runBusy(
          () => _authRepository.register(
            name: nameController.text.trim(),
            email: emailController.text.trim(),
            password: passwordController.text,
          ),
        ); */

        // Save registered user details locally
        final user = UserModel(
          id: '124',
          name: nameController.text.trim(),
          email: emailController.text.trim(),
          token: 'dummy_jwt_token_register',
        );
        debugPrint("--> [Register] Saving User to Storage: ${user.toJson()}");
        await _storage.saveUser(user);
        debugPrint("--> [Register] Read back user from Storage: ${_storage.getUser()?.toJson()}");

        Get.offAllNamed(AppRoutes.mainBottomNavScreen);
      } catch (error) {
        CommonSnackbar.showError(
          title: 'Error',
          message: error.toString(),
        );
      }
    }
  }

  Future<void> changePassword() async {
    final isValid = changePasswordFormKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (newPasswordTEController.text.trim() != confirmNewPasswordTEController.text.trim()) {
      CommonSnackbar.showError(
        title: "Validation Error",
        message: "Password Doesn't match",
      );
      return;
    }

    try {
      await runBusy(() => _authRepository.changePassword(
        currentPassword: currentPasswordTEController.text,
        newPassword: newPasswordTEController.text,
      ));

      CommonSnackbar.showSuccess(
        title: "Success",
        message: "Password changed successfully",
      );

      // Clear fields
      currentPasswordTEController.clear();
      newPasswordTEController.clear();
      confirmNewPasswordTEController.clear();

      Get.back();
    } catch (error) {
      CommonSnackbar.showError(
        title: "Error",
        message: error.toString(),
      );
    }
  }

  void submitForgotPassword() => _validate(
    forgotPasswordFormKey,
    AppRoutes.otpVerification,
  );


  void verifyOtp() => _validate(otpFormKey, AppRoutes.login);


  void _validate(GlobalKey<FormState> key, String nextRoute,) {
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
    currentPasswordTEController.dispose();
    newPasswordTEController.dispose();
    confirmNewPasswordTEController.dispose();
    super.onClose();
  }
}
