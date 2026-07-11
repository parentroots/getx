import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/app_bar/common_app_bar.dart';
import 'package:getx_template/component/button/common_button.dart';
import 'package:getx_template/component/layout/common_text.dart';
import 'package:getx_template/component/layout/common_scaffold.dart';
import 'package:getx_template/utils/constants/app_colors.dart';
import 'package:getx_template/utils/extensions/context_extensions.dart';
import 'package:getx_template/core/theme/app_spacing.dart';
import 'package:getx_template/utils/helper/validators.dart';
import 'package:getx_template/features/auth/screen/controller/auth_controller.dart';
import 'package:pinput/pinput.dart';


class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Pin theme matching premium design system
    final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 54.h,
      textStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: theme.textTheme.bodyLarge?.color,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow ?? theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: context.appColors.primary, width: 2),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: context.appColors.primary.withValues(alpha: 0.5)),
      ),
    );

    return CommonScaffold(
      appBar: const CommonAppBar(title: 'Verification'),
      body: Form(
        key: controller.otpFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.h),
            const CommonText(
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
            

            Center(
              child: Pinput(
                length: 6,
                controller: controller.otpController,
                validator: (value) => Validators.required(value, field: 'Code'),
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                showCursor: true,
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                keyboardType: TextInputType.number,
              ),
            ),
            
            SizedBox(height: AppSpacing.lg.h),
            CommonButton(titleText: 'Verify', onTap: controller.verifyOtp),
          ],
        ),
      ),
    );
  }
}
