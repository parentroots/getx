import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/common_app_bar.dart';
import 'package:getx_template/component/common_button.dart';
import 'package:getx_template/component/common_card.dart';
import 'package:getx_template/component/layout/common_bottom_nav_bar.dart';
import 'package:getx_template/component/layout/common_drawer.dart';
import 'package:getx_template/component/layout/common_text.dart';
import 'package:getx_template/component/layout/common_scaffold.dart';
import 'package:getx_template/core/routing/app_routes.dart';
import 'package:getx_template/core/theme/app_spacing.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      drawer: const CommonDrawer(),
      bottomNavigationBar: const CommonBottomNavBar(),
      appBar: const CommonTopBar(title: 'Profile', showBack: true),
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
          CommonCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                  'Generic profile surface',
                  variant: TextVariant.title,
                  weight: TextWeight.bold,
                ),
                SizedBox(height: AppSpacing.sm.h),
                const CommonText(
                  'Connect this screen to your authenticated user model when your app has one.',
                  variant: TextVariant.body,
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.lg.h),
          CommonButton(
            label: 'Edit profile',
            icon: Icon(Icons.edit_outlined, size: 20.r),
            onPressed: () => Get.toNamed(AppRoutes.editProfile),
          ),
        ],
      ),
    );
  }
}
