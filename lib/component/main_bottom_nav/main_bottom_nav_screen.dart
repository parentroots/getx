import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/main_bottom_nav/main_bottom_nav_bar.dart';
import 'package:getx_template/component/layout/common_drawer.dart';
import 'package:getx_template/component/layout/common_scaffold.dart';
import 'package:getx_template/features/home/screen/view/home_screen.dart';
import 'package:getx_template/features/message/screen/view/message_screen.dart';
import 'package:getx_template/features/profile/screen/view/profile_screen.dart';
import 'package:getx_template/component/main_bottom_nav/main_bottom_nav_controller.dart';

class MainBottomNavScreen extends GetView<MainBottomNavController> {
  const MainBottomNavScreen({super.key});

  static const List<Widget> _screens = [
    HomeScreen(),
    MessageScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      scaffoldKey: controller.scaffoldKey,
      drawer: const CommonDrawer(),
      bottomNavigationBar: const MainBottomNavBar(),
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: _screens,
        ),
      ),
    );
  }
}
