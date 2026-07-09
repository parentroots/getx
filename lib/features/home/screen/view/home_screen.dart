import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/app_bar/common_app_bar.dart';
import 'package:getx_template/component/button/common_button.dart';
import 'package:getx_template/component/card/common_card.dart';
import 'package:getx_template/component/dialogs/common_snackbar.dart';
import 'package:getx_template/component/layout/common_drawer.dart';
import 'package:getx_template/component/layout/common_scaffold.dart';
import 'package:getx_template/core/routing/app_routes.dart';
import 'package:getx_template/core/theme/app_spacing.dart';

import 'package:getx_template/component/main_bottom_nav/main_bottom_nav_controller.dart';
import 'package:getx_template/utils/constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBar: CommonAppBar(
        title: 'Home',
        showBack: false,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Get
                .find<MainBottomNavController>()
                .openDrawer();
          },
        ),
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: () =>
                Get.toNamed(AppRoutes.notifications),
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(AppSpacing.md.r),
        children: [
          Text(
            'Welcome back!',
            style: Theme
                .of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppSpacing.md.h),
          CommonCard(


            elevation: 4,
            borderRadius: 4,

            shadowColor: AppColors.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Actions',
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleMedium,
                ),
                SizedBox(height: AppSpacing.sm.h),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
