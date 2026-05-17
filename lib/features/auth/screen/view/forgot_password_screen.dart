import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/app_app_bar.dart';
import 'package:getx_template/component/app_button.dart';
import 'package:getx_template/component/app_text_field.dart';
import 'package:getx_template/component/layout/app_text.dart';
import 'package:getx_template/component/layout/responsive_scaffold.dart';
import 'package:getx_template/core/theme/app_spacing.dart';
import 'package:getx_template/core/utils/validators.dart';
import 'package:getx_template/features/auth/screen/controller/auth_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return ResponsiveScaffold(
      appBar: const AppTopBar(title: 'Forgot password'),
      body: Form(
        key: controller.forgotPasswordFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.h),
            AppText(
              'Reset access',
              variant: TextVariant.header,
              weight: TextWeight.bold,
            ),
            SizedBox(height: AppSpacing.md.h),
            const AppText(
              'Enter the email connected to the account. Wire this to your auth provider when you build the app.',
              variant: TextVariant.body,
              color: Colors.grey,
            ),
            SizedBox(height: AppSpacing.xl.h),
            AppTextField(
              label: 'Email',
              controller: controller.emailController,
              validator: Validators.email,
              prefixIcon: Icons.email_outlined,
            ),
            SizedBox(height: AppSpacing.lg.h),
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
