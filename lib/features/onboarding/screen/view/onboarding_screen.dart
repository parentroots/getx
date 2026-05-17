import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/app_button.dart';
import 'package:getx_template/component/layout/app_text.dart';
import 'package:getx_template/component/layout/responsive_scaffold.dart';
import 'package:getx_template/core/routing/app_routes.dart';
import 'package:getx_template/core/theme/app_spacing.dart';
import 'package:getx_template/features/onboarding/screen/controller/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnboardingController>();

    return ResponsiveScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Icon(
            Icons.auto_awesome_motion_rounded,
            size: 96.r,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(height: AppSpacing.xl.h),
          AppText(
            'A clean foundation for your next app',
            variant: TextVariant.title,
            weight: TextWeight.bold,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSpacing.md.h),
          const AppText(
            'Routes, services, theme, widgets, networking, storage, and Firebase-ready setup are already wired so you can focus on your product.',
            textAlign: TextAlign.center,
            variant: TextVariant.body,
            color: Colors.grey,
          ),
          const Spacer(),
          AppButton(label: 'Get started', onPressed: controller.finish),
          SizedBox(height: AppSpacing.sm.h),
          TextButton(
            onPressed: () => Get.offAllNamed(AppRoutes.authWelcome),
            child: const AppText(
              'Skip',
              variant: TextVariant.body,
              weight: TextWeight.medium,
            ),
          ),
        ],
      ),
    );
  }
}
