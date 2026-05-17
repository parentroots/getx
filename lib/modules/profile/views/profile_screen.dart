import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/modules/profile/controllers/profile_controller.dart';
import 'package:getx_template/routes/app_routes.dart';
import 'package:getx_template/theme/app_spacing.dart';
import 'package:getx_template/widgets/app_app_bar.dart';
import 'package:getx_template/widgets/app_button.dart';
import 'package:getx_template/widgets/app_card.dart';
import 'package:getx_template/widgets/layout/responsive_scaffold.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      appBar: const AppTopBar(title: 'Profile'),
      body: ListView(
        children: [
          CircleAvatar(
            radius: 44,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Icon(
              Icons.person_outline,
              size: 44,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Generic profile surface',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.sm),
                const Text(
                  'Connect this screen to your authenticated user model when your app has one.',
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            label: 'Edit profile',
            icon: Icons.edit_outlined,
            onPressed: () => Get.toNamed(AppRoutes.editProfile),
          ),
        ],
      ),
    );
  }
}
