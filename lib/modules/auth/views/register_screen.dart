import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/core/utils/validators.dart';
import 'package:getx_template/modules/auth/controllers/auth_controller.dart';
import 'package:getx_template/theme/app_spacing.dart';
import 'package:getx_template/widgets/app_app_bar.dart';
import 'package:getx_template/widgets/app_button.dart';
import 'package:getx_template/widgets/app_text_field.dart';
import 'package:getx_template/widgets/layout/responsive_scaffold.dart';

class RegisterScreen extends GetView<AuthController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      appBar: const AppTopBar(title: 'Create account'),
      body: Form(
        key: controller.registerFormKey,
        child: ListView(
          children: [
            Text(
              'Start with a clean account surface',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.xl),
            AppTextField(
              label: 'Name',
              controller: controller.nameController,
              validator: (value) => Validators.required(value, field: 'Name'),
              prefixIcon: Icons.person_outline,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              label: 'Email',
              controller: controller.emailController,
              validator: Validators.email,
              prefixIcon: Icons.email_outlined,
            ),
            const SizedBox(height: AppSpacing.md),
            AppTextField(
              label: 'Password',
              controller: controller.passwordController,
              validator: Validators.password,
              obscureText: true,
              prefixIcon: Icons.lock_outline,
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: 'Create account',
              onPressed: controller.submitRegister,
            ),
          ],
        ),
      ),
    );
  }
}
