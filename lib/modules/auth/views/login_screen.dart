import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/core/utils/validators.dart';
import 'package:getx_template/modules/auth/controllers/auth_controller.dart';
import 'package:getx_template/routes/app_routes.dart';
import 'package:getx_template/theme/app_spacing.dart';
import 'package:getx_template/widgets/app_app_bar.dart';
import 'package:getx_template/widgets/app_button.dart';
import 'package:getx_template/widgets/app_text_field.dart';
import 'package:getx_template/widgets/layout/responsive_scaffold.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      appBar: const AppTopBar(title: 'Log in'),
      body: Form(
        key: controller.loginFormKey,
        child: ListView(
          children: [
            Text(
              'Access your workspace',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.xl),
            AppTextField(
              label: 'Email',
              controller: controller.emailController,
              validator: Validators.email,
              prefixIcon: Icons.email_outlined,
            ),
            const SizedBox(height: AppSpacing.md),
            Obx(
              () => AppTextField(
                label: 'Password',
                controller: controller.passwordController,
                validator: Validators.password,
                obscureText: controller.obscurePassword.value,
                prefixIcon: Icons.lock_outline,
                suffixIcon: IconButton(
                  tooltip: 'Toggle password visibility',
                  onPressed: controller.togglePasswordVisibility,
                  icon: Icon(
                    controller.obscurePassword.value
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Get.toNamed(AppRoutes.forgotPassword),
                child: const Text('Forgot password?'),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(label: 'Log in', onPressed: controller.submitLogin),
          ],
        ),
      ),
    );
  }
}
