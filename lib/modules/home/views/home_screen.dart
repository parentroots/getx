import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/modules/home/controllers/home_controller.dart';
import 'package:getx_template/routes/app_routes.dart';
import 'package:getx_template/theme/app_spacing.dart';
import 'package:getx_template/widgets/app_app_bar.dart';
import 'package:getx_template/widgets/app_card.dart';
import 'package:getx_template/widgets/layout/responsive_scaffold.dart';
import 'package:getx_template/widgets/states/empty_state_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      appBar: AppTopBar(
        title: 'Home',
        showBack: false,
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: () => Get.toNamed(AppRoutes.notifications),
            icon: const Icon(Icons.notifications_outlined),
          ),
          IconButton(
            tooltip: 'Settings',
            onPressed: () => Get.toNamed(AppRoutes.settings),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: ListView(
        children: [
          Text(
            'Starter workspace',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          const Text(
            'Replace these neutral surfaces with your app modules while keeping the infrastructure intact.',
          ),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Infrastructure ready',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                const Text(
                  'GetX routes, dependency injection, services, themes, utilities, and reusable widgets are wired.',
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          EmptyStateWidget(
            title: 'Build your first module',
            message:
                'Add feature data, domain, and presentation folders under lib/modules when your app requirements are known.',
            actionLabel: 'View profile',
            onAction: () => Get.toNamed(AppRoutes.profile),
          ),
        ],
      ),
    );
  }
}
