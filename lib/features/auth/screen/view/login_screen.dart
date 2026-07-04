import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/common_app_bar.dart';
import 'package:getx_template/component/common_button.dart';
import 'package:getx_template/component/common_switch.dart';
import 'package:getx_template/component/common_text_field.dart';
import 'package:getx_template/component/layout/common_scaffold.dart';
import 'package:getx_template/component/layout/common_text.dart';
import 'package:getx_template/core/constants/app_string.dart';
import 'package:getx_template/core/routing/app_routes.dart';
import 'package:getx_template/core/utils/helper/validators.dart';
import 'package:getx_template/features/auth/screen/controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return CommonScaffold(
      appBar: const CommonAppBar(
        title: 'Sign In',
        showBack: false,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
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
                        color: theme.primaryColor.withOpacity(0.1),
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
                      "Welcome Back",
                      variant: TextVariant.header,
                      weight: TextWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Center(
                    child: CommonText(
                      "Enter your credentials to continue into the app",
                      variant: TextVariant.body,
                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 36.h),

                  // Email Field
                  CommonTextField(
                    label: AppString.emailAddress,
                    hint: "name@example.com",
                    controller: controller.emailController,
                    prefixIcon: Icons.email_outlined,
                    validator: Validators.email,
                  ),
                  SizedBox(height: 16.h),

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
                              value: controller.isSwitchOn.value,
                              onChanged: (val) => controller.isSwitchOn.value = val,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          CommonText(
                            "Remember me",
                            variant: TextVariant.caption,
                            color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                        child: CommonText(
                          "Forgot Password?",
                          variant: TextVariant.caption,
                          color: theme.primaryColor,
                          weight: TextWeight.medium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),

                  // Login Button
                  CommonButton(
                    titleText: "Log In",
                    buttonWidth: double.maxFinite,
                    onTap: controller.submitLogin,
                  ),
                  SizedBox(height: 24.h),

                  // Register Redirection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonText(
                        "Don't have an account? ",
                        variant: TextVariant.body,
                        color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.register),
                        child: CommonText(
                          "Sign Up",
                          variant: TextVariant.body,
                          color: theme.primaryColor,
                          weight: TextWeight.bold,
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
