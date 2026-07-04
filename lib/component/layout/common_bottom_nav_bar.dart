import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/core/constants/app_colors.dart';
import 'package:getx_template/core/routing/app_routes.dart';

class _BottomNavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String route;

  const _BottomNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.route,
  });
}

class CommonBottomNavBar extends StatelessWidget {
  const CommonBottomNavBar({super.key});

  static const List<_BottomNavItem> _navItems = [
    _BottomNavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      label: 'Home',
      route: AppRoutes.home,
    ),
    _BottomNavItem(
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
      label: 'Profile',
      route: AppRoutes.profile,
    ),
    _BottomNavItem(
      icon: Icons.settings_outlined,
      activeIcon: Icons.settings_rounded,
      label: 'Settings',
      route: AppRoutes.settings,
    ),
  ];

  int _getCurrentIndex() {
    final route = Get.currentRoute;
    if (route == AppRoutes.editProfile) return 1;
    final index = _navItems.indexWhere((item) => item.route == route);
    return index != -1 ? index : 0; // Default to Home
  }

  void _onTabSelected(int index) {
    if (index == _getCurrentIndex()) return;
    Get.offAllNamed(_navItems[index].route);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final selectedIndex = _getCurrentIndex();

    return SafeArea(
      bottom: true,
      child: Container(
        height: 64.h,
        margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 12.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface.withValues(alpha: 0.9) : Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: isDark ? Colors.white.withValues(alpha: 0.08) : AppColors.border.withValues(alpha: 0.5),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black.withValues(alpha: 0.3) : AppColors.primary.withValues(alpha: 0.06),
              blurRadius: 20.r,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_navItems.length, (index) {
                final item = _navItems[index];
                final isSelected = index == selectedIndex;
                
                return GestureDetector(
                  onTap: () => _onTabSelected(index),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? (isDark ? AppColors.primary.withOpacity(0.15) : AppColors.primary.withOpacity(0.08))
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isSelected ? item.activeIcon : item.icon,
                          color: isSelected 
                              ? AppColors.primary 
                              : (isDark ? Colors.grey.shade500 : Colors.grey.shade600),
                          size: 22.r,
                        ),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          child: isSelected
                              ? Padding(
                                  padding: EdgeInsets.only(left: 8.w),
                                  child: Text(
                                    item.label,
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
