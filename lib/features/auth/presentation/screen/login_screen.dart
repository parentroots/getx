import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/app_bar/common_app_bar.dart';
import 'package:getx_template/component/button/common_button.dart';
import 'package:getx_template/component/image/common_image.dart';
import 'package:getx_template/component/switch/common_switch.dart';
import 'package:getx_template/component/tab_bar/common_tab_bar.dart';
import 'package:getx_template/component/text_field/common_text_field.dart';
import 'package:getx_template/component/layout/common_scaffold.dart';
import 'package:getx_template/component/layout/common_text.dart';
import 'package:getx_template/utils/constants/app_assets.dart';
import 'package:getx_template/utils/constants/app_colors.dart';
import 'package:getx_template/utils/constants/app_string.dart';
import 'package:getx_template/core/routing/app_routes.dart';
import 'package:getx_template/utils/extensions/context_extensions.dart';
import 'package:getx_template/utils/extensions/screen_extensions.dart';
import 'package:getx_template/utils/helper/validators.dart';
import 'package:getx_template/features/auth/presentation/controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final theme = Theme.of(context);

    return CommonScaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: controller.loginFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Logo Placeholder
                  Center(
                    child: Container(
                      height: 80.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.rocket_launch_rounded,
                        size: 40.r,
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Greeting Titles
                  Center(
                    child: CommonText(
                      color: context.appColors.text,
                      AppString.welcomeBack,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Center(
                    child: CommonText(
                      AppString.loginCredentialsDesc,
                      color: context.appColors.textSecondary,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 36.h),

                  CommonText(AppString.emailAddress, fontWeight: FontWeight.bold),

                  6.height,

                  // Email Field
                  CommonTextField(
                    label: AppString.emailAddress,
                    hint: "name@gmail.com",
                    controller: controller.emailController,
                    prefixIcon: Icons.email_outlined,
                    validator: Validators.email,
                  ),
                  SizedBox(height: 12.h),

                  CommonText(AppString.password, fontWeight: FontWeight.bold),

                  6.height,

                  // Password Field
                  CommonTextField(
                    label: AppString.password,
                    hint: "••••••••",
                    controller: controller.passwordController,
                    obscureText: true,
                    prefixIcon: Icons.lock_outline,
                    validator: Validators.password,
                  ),
                  SizedBox(height: 16.h),

                  // Remember Me & Forgot Password Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Obx(
                            () => CommonSwitch(
                              height: 18.h,
                              width: 40,
                              activeColor: context.appColors.primary,
                              enableHaptic: true,
                              value: controller.isSwitchOn.value,
                              onChanged: (val) =>
                                  controller.isSwitchOn.value = val,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          CommonText(
                            AppString.rememberMe,
                            color: context.appColors.textSecondary,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                        child: CommonText(
                          AppString.forgotPasswordQuestion,
                          color: theme.primaryColor,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 120.h),

                  // Login Button
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return CommonButton(
                      isLoading: controller.isLoading.value,
                      borderColor: context.appColors.white,
                      borderWidth: 1,
                      titleText: AppString.logInButton,
                      buttonWidth: double.maxFinite,
                      onTap: controller.submitLogin,
                    );
                  }),

                  SizedBox(height: 24.h),

                  // Register Redirection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonText(
                        AppString.dontHaveAccount,
                        color: context.appColors.textSecondary,
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.register),
                        child: CommonText(
                          AppString.signUpButton,
                          color: context.appColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
