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
        actions: [
          IconButton(
            tooltip: 'Notifications',
            onPressed: () => Get.toNamed(AppRoutes.notifications),
            icon: const Icon(Icons.notifications_outlined),
          ),

        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(AppSpacing.md.r),
        children: [
          Text(
            'Welcome back!',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: AppSpacing.md.h),
          CommonCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Actions',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: AppSpacing.sm.h),
                CommonButton(
                  titleText: 'Explore Features',
                  buttonWidth: double.maxFinite,
                  onTap: () => Get.toNamed(AppRoutes.showcase),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
