import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/common_app_bar.dart';
import 'package:getx_template/component/common_button.dart';
import 'package:getx_template/component/common_card.dart';
import 'package:getx_template/component/layout/common_bottom_nav_bar.dart';
import 'package:getx_template/component/layout/common_drawer.dart';
import 'package:getx_template/component/layout/common_scaffold.dart';
import 'package:getx_template/component/states/empty_state_widget.dart';
import 'package:getx_template/core/routing/app_routes.dart';
import 'package:getx_template/core/theme/app_spacing.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      drawer: const CommonDrawer(),
      bottomNavigationBar: const CommonBottomNavBar(),
      appBar: CommonAppBar(
        title: 'Home',
        showBack: true,
        // Automatically implies leading (hamburger icon) for the drawer
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
          CommonCard(
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
                const SizedBox(height: AppSpacing.md),
                CommonButton(
                  titleText: 'Launch Widget Showcase',
                  buttonWidth: double.maxFinite,
                  onTap: () => Get.toNamed(AppRoutes.showcase),
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
