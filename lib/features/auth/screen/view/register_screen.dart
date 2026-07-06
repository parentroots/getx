import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/app_bar/common_app_bar.dart';
import 'package:getx_template/component/button/common_button.dart';
import 'package:getx_template/component/text_field/common_text_field.dart';
import 'package:getx_template/component/layout/common_text.dart';
import 'package:getx_template/component/layout/common_scaffold.dart';
import 'package:getx_template/core/theme/app_spacing.dart';
import 'package:getx_template/utils/helper/validators.dart';
import 'package:getx_template/features/auth/screen/controller/auth_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return CommonScaffold(
      appBar: const CommonAppBar(title: 'Create account'),
      body: Form(
        key: controller.registerFormKey,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          children: [
            CommonText(
              'Start with a clean account surface',
              variant: TextVariant.header,
              weight: TextWeight.bold,
            ),
            SizedBox(height: AppSpacing.xl.h),
            CommonTextField(
              label: 'Name',
              controller: controller.nameController,
              validator: (value) => Validators.required(value, field: 'Name'),
              prefixIcon: Icons.person_outline,
            ),
            SizedBox(height: AppSpacing.md.h),
            CommonTextField(
              label: 'Email',
              controller: controller.emailController,
              validator: Validators.email,
              prefixIcon: Icons.email_outlined,
            ),
            SizedBox(height: AppSpacing.md.h),
            CommonTextField(
              label: 'Password',
              controller: controller.passwordController,
              validator: Validators.password,
              obscureText: true,
              prefixIcon: Icons.lock_outline,
            ),
            SizedBox(height: AppSpacing.lg.h),
            CommonButton(
              titleText: 'Create account',
              onTap: controller.submitRegister,
            ),
          ],
        ),
      ),
    );
  }
}
