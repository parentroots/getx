import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/button/common_button.dart';
import 'package:getx_template/component/layout/common_scaffold.dart';
import 'package:getx_template/component/layout/common_text.dart';
import 'package:getx_template/core/routing/app_routes.dart';
import 'package:getx_template/core/theme/app_spacing.dart';
import 'package:getx_template/utils/constants/app_colors.dart';
import 'package:getx_template/utils/constants/app_string.dart';
import 'package:getx_template/utils/extensions/context_extensions.dart';
import 'package:getx_template/utils/extensions/screen_extensions.dart';

class AuthWelcomeScreen extends StatelessWidget {
  const AuthWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          200.height,
          Icon(
            Icons.shield_outlined,
            size: 92,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            AppString.welcome,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),

          CommonText(
            fontSize: 12.sp,
            textAlign: TextAlign.center,
            AppString.welcomeDesc,
          ),

          60.height,

          Row(
            children: [
              //login button=====================
              Expanded(
                child: CommonButton(
                  titleText: AppString.login,
                  onTap: () => Get.toNamed(AppRoutes.login),
                ),
              ),
              const SizedBox(width: AppSpacing.md),

              //sign-up button===================
              Expanded(
                child: CommonButton(
                  buttonColor: context.appColors.white,
                  border: true,
                  borderColor: context.appColors.primary,
                  titleText: AppString.signUp,
                  titleColor: Colors.black,
                  onTap: () => Get.toNamed(AppRoutes.register),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
