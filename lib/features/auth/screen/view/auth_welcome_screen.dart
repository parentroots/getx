import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/common_button.dart';
import 'package:getx_template/component/layout/responsive_scaffold.dart';
import 'package:getx_template/core/routing/app_routes.dart';
import 'package:getx_template/core/theme/app_spacing.dart';

class AuthWelcomeScreen extends StatelessWidget {
  const AuthWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Icon(
            Icons.shield_outlined,
            size: 92,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            'Welcome',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'Use this neutral authentication entry point as the starting surface for your app.',
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          CommonButton(
            label: 'Log in',
            onPressed: () => Get.toNamed(AppRoutes.login),
          ),
          const SizedBox(height: AppSpacing.md),
          CommonButton(
            label: 'Create account',
            isOutlined: true,
            onPressed: () => Get.toNamed(AppRoutes.register),
          ),
        ],
      ),
    );
  }
}
