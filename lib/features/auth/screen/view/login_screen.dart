import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/app_app_bar.dart';
import 'package:getx_template/component/app_button.dart';
import 'package:getx_template/component/app_text_field.dart';
import 'package:getx_template/component/layout/app_text.dart';
import 'package:getx_template/component/layout/responsive_scaffold.dart';
import 'package:getx_template/core/routing/app_routes.dart';
import 'package:getx_template/core/theme/app_spacing.dart';
import 'package:getx_template/core/utils/validators.dart';
import 'package:getx_template/features/auth/screen/controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return ResponsiveScaffold(
      appBar: const AppTopBar(title: 'Log in'),
      body: Form(
        key: controller.loginFormKey,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          children: [
            AppText(
              'Access your workspace',
              variant: TextVariant.header,
              weight: TextWeight.bold,
            ),
            SizedBox(height: AppSpacing.xl.h),
            AppTextField(
              label: 'Email',
              controller: controller.emailController,
              validator: Validators.email,
              prefixIcon: Icons.email_outlined,
            ),
            SizedBox(height: AppSpacing.md.h),
            Obx(
              () => AppTextField(
                label: 'Password',
                controller: controller.passwordController,
                validator: Validators.password,
                obscureText: controller.obscurePassword.value,
                prefixIcon: Icons.lock_outline,
                suffixWidget: IconButton(
                  tooltip: 'Toggle password visibility',
                  onPressed: controller.togglePasswordVisibility,
                  icon: Icon(
                    controller.obscurePassword.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 22.r,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Get.toNamed(AppRoutes.forgotPassword),
                child: const AppText(
                  'Forgot password?',
                  variant: TextVariant.body,
                  weight: TextWeight.medium,
                ),
              ),
            ),
            SizedBox(height: AppSpacing.lg.h),
            AppButton(label: 'Log in', onPressed: controller.submitLogin),
          ],
        ),
      ),
    );
  }
}
