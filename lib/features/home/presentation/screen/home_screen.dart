import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/app_bar/common_app_bar.dart';
import 'package:getx_template/component/button/common_button.dart';
import 'package:getx_template/component/card/common_card.dart';
import 'package:getx_template/component/layout/common_scaffold.dart';
import 'package:getx_template/component/layout/common_text.dart';
import 'package:getx_template/core/theme/app_spacing.dart';
import 'package:getx_template/features/home/presentation/controller/home_controller.dart';
import 'package:getx_template/component/main_bottom_nav/main_bottom_nav_controller.dart';
import 'package:getx_template/utils/constants/app_string.dart';
import 'package:getx_template/utils/extensions/context_extensions.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appBar: CommonAppBar(
        centerTitle: true,
        titleColor: context.appColors.primary,
        title: AppString.home,
        showBack: false,
        leading: IconButton(
          icon: Icon(Icons.menu, color: context.appColors.primary),
          onPressed: () {
            Get.find<MainBottomNavController>().openDrawer();
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(AppSpacing.lg),
        children: [
          CommonButton(
            buttonColor: context.appColors.primary,
            titleText: AppString.thisIsButton,
          ),
          SizedBox(height: AppSpacing.md),
          CommonCard(
            color: context.appColors.border,
            child: CommonText(
              AppString.welcomeToTemplate,
              color: context.appColors.text,
            ),
          ),
        ],
      ),
    );
  }
}
