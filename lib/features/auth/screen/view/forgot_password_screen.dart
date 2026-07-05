import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/common_app_bar.dart';
import 'package:getx_template/component/common_button.dart';
import 'package:getx_template/component/common_text_field.dart';
import 'package:getx_template/component/layout/common_text.dart';
import 'package:getx_template/component/layout/common_scaffold.dart';
import 'package:getx_template/core/theme/app_spacing.dart';
import 'package:getx_template/utils/helper/validators.dart';
import 'package:getx_template/features/auth/screen/controller/auth_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return CommonScaffold(
      appBar: const CommonAppBar(title: 'Forgot password'),
      body: Form(
        key: controller.forgotPasswordFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.h),
            CommonText(
              'Reset access',
              variant: TextVariant.header,
              weight: TextWeight.bold,
            ),
            SizedBox(height: AppSpacing.md.h),
            const CommonText(
              'Enter the email connected to the account. Wire this to your auth provider when you build the app.',
              variant: TextVariant.body,
              color: Colors.grey,
            ),
            SizedBox(height: AppSpacing.xl.h),
            CommonTextField(
              label: 'Email',
              controller: controller.emailController,
              validator: Validators.email,
              prefixIcon: Icons.email_outlined,
            ),
            SizedBox(height: AppSpacing.lg.h),
            CommonButton(
              titleText: 'Continue',
              onTap: controller.submitForgotPassword,
            ),
          ],
        ),
      ),
    );
  }
}
