import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/app_bar/common_app_bar.dart';
import 'package:getx_template/component/card/common_card.dart';
import 'package:getx_template/component/layout/common_text.dart';
import 'package:getx_template/component/layout/common_scaffold.dart';
import 'package:getx_template/core/theme/app_spacing.dart';
import 'package:getx_template/features/settings/screen/controller/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();
    return CommonScaffold(
      appBar: const CommonAppBar(
        centerTitle: true,
        title: 'Settings',
        showBack: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        children: [
          CommonCard(
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.person_outline, size: 24.r),
                  title: CommonText(
                    'Profile Details',
                    style: context.textTheme.bodyMedium,
                    fontWeight: FontWeight.w500,
                  ),
                  trailing: Icon(Icons.chevron_right, size: 24.r),
                  onTap: () => Get.back(),
                ),
                const Divider(),
                SizedBox(height: 12.h),
                Obx(
                  () => SegmentedButton<ThemeMode>(
                    segments: [
                      ButtonSegment(
                        value: ThemeMode.system,
                        label: CommonText('System', style: context.textTheme.bodySmall, fontSize: 11),
                        icon: Icon(Icons.brightness_auto, size: 16.r),
                      ),
                      ButtonSegment(
                        value: ThemeMode.light,
                        label: CommonText('Light', style: context.textTheme.bodySmall, fontSize: 11),
                        icon: Icon(Icons.light_mode, size: 16.r),
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        label: CommonText('Dark', style: context.textTheme.bodySmall, fontSize: 11),
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
          CommonText(
            'Keep app-level settings here. Feature-specific settings should live with their feature module.',
            style: context.textTheme.bodyMedium,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
