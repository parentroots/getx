import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/button/common_button.dart';
import 'package:getx_template/component/card/common_card.dart';
import 'package:getx_template/component/layout/common_text.dart';
import 'package:getx_template/component/layout/common_scaffold.dart';
import 'package:getx_template/core/routing/app_routes.dart';
import 'package:getx_template/core/theme/app_spacing.dart';
import 'package:getx_template/features/profile/screen/controller/profile_controller.dart';
import 'package:getx_template/utils/extensions/screen_extensions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    controller.loadUserData();
    return CommonScaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
          Obx(() {
            final user = controller.rxUser.value;
            return CommonCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    user?.name ?? 'Guest User',
                    variant: TextVariant.title,
                    weight: TextWeight.bold,
                  ),
                  SizedBox(height: AppSpacing.sm.h),
                  CommonText(
                    user?.email ?? 'No email associated',
                    variant: TextVariant.body,
                  ),
                ],
              ),
            );
          }),
          SizedBox(height: AppSpacing.lg.h),
          CommonButton(
            titleText: "Edit Profile",
            onTap: () => Get.toNamed(AppRoutes.editProfile),
          ),

          10.height,
          CommonButton(
            titleText: "Change Password",
            onTap: () => Get.toNamed(AppRoutes.changePassword),
          ),


        ],
      ),
    );
  }
}
