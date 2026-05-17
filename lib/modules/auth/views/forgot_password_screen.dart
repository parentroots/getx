import 'package:flutter/material.dart';
import 'package:getx_template/core/utils/validators.dart';
import 'package:getx_template/modules/auth/controllers/auth_controller.dart';
import 'package:getx_template/theme/app_spacing.dart';
import 'package:getx_template/widgets/app_app_bar.dart';
import 'package:getx_template/widgets/app_button.dart';
import 'package:getx_template/widgets/app_text_field.dart';
import 'package:getx_template/widgets/layout/responsive_scaffold.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends GetView<AuthController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      appBar: const AppTopBar(title: 'Forgot password'),
      body: Form(
        key: controller.forgotPasswordFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Reset access',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            const Text(
              'Enter the email connected to the account. Wire this to your auth provider when you build the app.',
            ),
            const SizedBox(height: AppSpacing.xl),
            AppTextField(
              label: 'Email',
              controller: controller.emailController,
              validator: Validators.email,
              prefixIcon: Icons.email_outlined,
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: 'Continue',
              onPressed: controller.submitForgotPassword,
            ),
          ],
        ),
      ),
    );
  }
}
