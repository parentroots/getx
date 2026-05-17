import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/core/routing/app_routes.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({super.key});

  int _getCurrentIndex() {
    final route = Get.currentRoute;
    if (route == AppRoutes.profile || route == AppRoutes.editProfile) {
      return 1;
    } else if (route == AppRoutes.settings) {
      return 2;
    }
    return 0; // Default to Home
  }

  void _onTabSelected(int index) {
    if (index == _getCurrentIndex()) return;

    String targetRoute;
    switch (index) {
      case 1:
        targetRoute = AppRoutes.profile;
        break;
      case 2:
        targetRoute = AppRoutes.settings;
        break;
      case 0:
      default:
        targetRoute = AppRoutes.home;
        break;
    }

    // Modern route transitions, clearing previous navigation logs
    Get.offAllNamed(targetRoute);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedIndex = _getCurrentIndex();

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16.r,
            offset: Offset(0, -4.h),
          ),
        ],
      ),
      child: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: _onTabSelected,
        elevation: 0,
        backgroundColor: theme.brightness == Brightness.dark
            ? theme.colorScheme.surface
            : Colors.white,
        indicatorColor: theme.primaryColor.withOpacity(0.12),
        height: 68.h,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, size: 24.r),
            selectedIcon: Icon(Icons.home_rounded, size: 24.r, color: theme.primaryColor),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded, size: 24.r),
            selectedIcon: Icon(Icons.person_rounded, size: 24.r, color: theme.primaryColor),
            label: 'Profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined, size: 24.r),
            selectedIcon: Icon(Icons.settings_rounded, size: 24.r, color: theme.primaryColor),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
