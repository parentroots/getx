import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/app_bar/common_app_bar.dart';
import 'package:getx_template/component/button/common_button.dart';
import 'package:getx_template/component/card/common_card.dart';
import 'package:getx_template/component/switch/common_switch.dart';
import 'package:getx_template/component/text_field/common_text_field.dart';
import 'package:getx_template/component/dialogs/common_dialog.dart';
import 'package:getx_template/component/layout/common_scaffold.dart';
import 'package:getx_template/component/layout/common_text.dart';
import 'package:getx_template/core/theme/app_spacing.dart';
import 'package:getx_template/features/home/screen/controller/home_controller.dart';
import 'package:getx_template/component/main_bottom_nav/main_bottom_nav_controller.dart';
import 'package:getx_template/utils/extensions/context_extensions.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return CommonScaffold(

      appBar: CommonAppBar(
        centerTitle: true,
        title: 'Home',
        showBack: false,
      /*  leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Get.find<MainBottomNavController>().openDrawer();
          },
        ),*/
      ),
      body: Column(
        children: [



          CommonButton(

            buttonColor: context.appColors.testColor,
              titleText: "This Is Buttton"),





          _buildThemeToggle(context, isDark),


        ],


      ),
    );
  }


  Widget _buildThemeToggle(
      BuildContext context,
      bool isDark,
      ) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: SwitchListTile(
        value: isDark,
        onChanged: (bool val) {
          Get.changeThemeMode(
            val ? ThemeMode.dark : ThemeMode.light,
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        activeColor: context.appColors.primary,
      ),
    );
  }
}
