import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/core/utils/validators.dart';
import 'package:getx_template/modules/auth/controllers/auth_controller.dart';
import 'package:getx_template/theme/app_spacing.dart';
import 'package:getx_template/widgets/app_app_bar.dart';
import 'package:getx_template/widgets/app_button.dart';
import 'package:getx_template/widgets/app_text_field.dart';
import 'package:getx_template/widgets/layout/responsive_scaffold.dart';

class OtpVerificationScreen extends GetView<AuthController> {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      appBar: const AppTopBar(title: 'Verification'),
      body: Form(
        key: controller.otpFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter code',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.md),
            const Text(
              'This screen is provider-neutral and ready for SMS, email, or authenticator-code flows.',
            ),
            const SizedBox(height: AppSpacing.xl),
            AppTextField(
              label: 'Code',
              controller: controller.otpController,
              validator: (value) => Validators.required(value, field: 'Code'),
              prefixIcon: Icons.pin_outlined,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(label: 'Verify', onPressed: controller.verifyOtp),
          ],
        ),
      ),
    );
  }
}
