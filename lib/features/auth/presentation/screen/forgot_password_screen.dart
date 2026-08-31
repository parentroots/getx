import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/app_bar/common_app_bar.dart';
import 'package:getx_template/component/button/common_button.dart';
import 'package:getx_template/component/text_field/common_text_field.dart';
import 'package:getx_template/component/layout/common_text.dart';
import 'package:getx_template/component/layout/common_scaffold.dart';
import 'package:getx_template/utils/constants/app_string.dart';
import 'package:getx_template/core/theme/app_spacing.dart';
import 'package:getx_template/utils/extensions/context_extensions.dart';
import 'package:getx_template/utils/helper/validators.dart';
import 'package:getx_template/features/auth/presentation/controller/auth_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return CommonScaffold(
      appBar: const CommonAppBar(title: AppString.forgotPasswordTitle),
      body: Form(
        key: controller.forgotPasswordFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.h),
            CommonText(AppString.resetAccess, fontWeight: FontWeight.bold),
            SizedBox(height: AppSpacing.md.h),
            CommonText(
              AppString.forgotPasswordDesc,
              color: context.appColors.textSecondary,
            ),
            SizedBox(height: AppSpacing.xl.h),
            CommonTextField(
              label: AppString.email,
              controller: controller.emailController,
              validator: Validators.email,
              prefixIcon: Icons.email_outlined,
            ),
            SizedBox(height: AppSpacing.lg.h),
            CommonButton(
              titleText: AppString.continues,
              onTap: controller.submitForgotPassword,
            ),
          ],
        ),
      ),
    );
  }
}
