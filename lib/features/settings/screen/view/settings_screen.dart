import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/app_app_bar.dart';
import 'package:getx_template/component/app_card.dart';
import 'package:getx_template/component/layout/app_bottom_nav_bar.dart';
import 'package:getx_template/component/layout/app_drawer.dart';
import 'package:getx_template/component/layout/app_text.dart';
import 'package:getx_template/component/layout/responsive_scaffold.dart';
import 'package:getx_template/core/routing/app_routes.dart';
import 'package:getx_template/core/theme/app_spacing.dart';
import 'package:getx_template/features/settings/screen/controller/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();
    return ResponsiveScaffold(
      drawer: const AppDrawer(),
      bottomNavigationBar: const AppBottomNavBar(),
      appBar: const AppTopBar(title: 'Settings', showBack: true),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        children: [
          AppCard(
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.person_outline, size: 24.r),
                  title: const AppText(
                    'Profile',
                    variant: TextVariant.body,
                    weight: TextWeight.medium,
                  ),
                  trailing: Icon(Icons.chevron_right, size: 24.r),
                  onTap: () => Get.toNamed(AppRoutes.profile),
                ),
                const Divider(),
                SizedBox(height: 12.h),
                Obx(
                  () => SegmentedButton<ThemeMode>(
                    segments: [
                      ButtonSegment(
                        value: ThemeMode.system,
                        label: AppText('System', variant: TextVariant.caption, fontSize: 11.sp),
                        icon: Icon(Icons.brightness_auto, size: 16.r),
                      ),
                      ButtonSegment(
                        value: ThemeMode.light,
                        label: AppText('Light', variant: TextVariant.caption, fontSize: 11.sp),
                        icon: Icon(Icons.light_mode, size: 16.r),
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        label: AppText('Dark', variant: TextVariant.caption, fontSize: 11.sp),
                        icon: Icon(Icons.dark_mode, size: 16.r),
                      ),
                    ],
                    selected: {controller.themeMode.value},
                    onSelectionChanged: (value) =>
                        controller.setThemeMode(value.first),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppSpacing.lg.h),
          const AppText(
            'Keep app-level settings here. Feature-specific settings should live with their feature module.',
            variant: TextVariant.body,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
