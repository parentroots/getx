import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/modules/onboarding/controllers/onboarding_controller.dart';
import 'package:getx_template/routes/app_routes.dart';
import 'package:getx_template/theme/app_spacing.dart';
import 'package:getx_template/widgets/app_button.dart';
import 'package:getx_template/widgets/layout/responsive_scaffold.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Icon(
            Icons.auto_awesome_motion_rounded,
            size: 96,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            'A clean foundation for your next app',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Routes, services, theme, widgets, networking, storage, and Firebase-ready setup are already wired so you can focus on your product.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Spacer(),
          AppButton(label: 'Get started', onPressed: controller.finish),
          const SizedBox(height: AppSpacing.sm),
          TextButton(
            onPressed: () => Get.offAllNamed(AppRoutes.authWelcome),
            child: const Text('Skip'),
          ),
        ],
      ),
    );
  }
}
