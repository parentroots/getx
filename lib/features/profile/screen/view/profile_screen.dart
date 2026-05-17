import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/app_app_bar.dart';
import 'package:getx_template/component/app_button.dart';
import 'package:getx_template/component/app_card.dart';
import 'package:getx_template/component/layout/app_bottom_nav_bar.dart';
import 'package:getx_template/component/layout/app_drawer.dart';
import 'package:getx_template/component/layout/app_text.dart';
import 'package:getx_template/component/layout/responsive_scaffold.dart';
import 'package:getx_template/core/routing/app_routes.dart';
import 'package:getx_template/core/theme/app_spacing.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      drawer: const AppDrawer(),
      bottomNavigationBar: const AppBottomNavBar(),
      appBar: const AppTopBar(title: 'Profile', showBack: true),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        children: [
          CircleAvatar(
            radius: 44.r,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Icon(
              Icons.person_outline,
              size: 44.r,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: AppSpacing.lg.h),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  'Generic profile surface',
                  variant: TextVariant.title,
                  weight: TextWeight.bold,
                ),
                SizedBox(height: AppSpacing.sm.h),
                const AppText(
                  'Connect this screen to your authenticated user model when your app has one.',
                  variant: TextVariant.body,
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.lg.h),
          AppButton(
            label: 'Edit profile',
            icon: Icon(Icons.edit_outlined, size: 20.r),
            onPressed: () => Get.toNamed(AppRoutes.editProfile),
          ),
        ],
      ),
    );
  }
}
