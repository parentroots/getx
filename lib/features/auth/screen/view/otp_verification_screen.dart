import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/common_app_bar.dart';
import 'package:getx_template/component/common_button.dart';
import 'package:getx_template/component/common_text_field.dart';
import 'package:getx_template/component/layout/common_text.dart';
import 'package:getx_template/component/layout/common_scaffold.dart';
import 'package:getx_template/core/theme/app_spacing.dart';
import 'package:getx_template/core/utils/validators.dart';
import 'package:getx_template/features/auth/screen/controller/auth_controller.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return CommonScaffold(
      appBar: const CommonAppBar(title: 'Verification'),
      body: Form(
        key: controller.otpFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.h),
            CommonText(
              'Enter code',
              variant: TextVariant.header,
              weight: TextWeight.bold,
            ),
            SizedBox(height: AppSpacing.md.h),
            const CommonText(
              'This screen is provider-neutral and ready for SMS, email, or authenticator-code flows.',
              variant: TextVariant.body,
              color: Colors.grey,
            ),
            SizedBox(height: AppSpacing.xl.h),
            CommonTextField(
              label: 'Code',
              controller: controller.otpController,
              validator: (value) => Validators.required(value, field: 'Code'),
              prefixIcon: Icons.pin_outlined,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: AppSpacing.lg.h),
            CommonButton(titleText: 'Verify', onTap: controller.verifyOtp),
          ],
        ),
      ),
    );
  }
}
