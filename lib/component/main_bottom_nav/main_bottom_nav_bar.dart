import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:getx_template/utils/extensions/context_extensions.dart';
import 'package:getx_template/component/main_bottom_nav/main_bottom_nav_controller.dart';

class _BottomNavItem {
  final IconData? icon;
  final IconData? activeIcon;
  final String? svgIcon;
  final String? svgActiveIcon;
  final String label;

  const _BottomNavItem({
    this.icon,
    this.activeIcon,
    this.svgIcon,
    this.svgActiveIcon,
    required this.label,
  });
}

class MainBottomNavBar extends StatelessWidget {
  const MainBottomNavBar({super.key});

  static const List<_BottomNavItem> _navItems = [
    _BottomNavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      label: 'Home',
    ),
    _BottomNavItem(
      icon: Icons.message_outlined,
      activeIcon: Icons.message,
      label: 'Message',
    ),
    _BottomNavItem(
      icon: Icons.person_2_outlined,
      activeIcon: Icons.person,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainBottomNavController>();

    return Container(
      decoration: BoxDecoration(
        color: context.appColors.surface,
        border: Border(
          top: BorderSide(
            color: context.appColors.border.withValues(alpha: 0.4),
            width: 1.r,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        bottom: true,
        child: SizedBox(
          height: 60.h,
          child: Stack(
            children: [
              // Top sliding indicator line
              Obx(() {
                final selectedIndex = controller.currentIndex.value;
                return AnimatedAlign(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  alignment: Alignment(
                    -1.0 + (selectedIndex * (2.0 / (_navItems.length - 1))),
                    -1.0, // Top aligned
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 1 / _navItems.length,
                    child: Container(
                      height: 3.h,
                      margin: EdgeInsets.symmetric(horizontal: 24.w),
                      decoration: BoxDecoration(
                        color: context.appColors.primary,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(3.r),
                          bottomRight: Radius.circular(3.r),
                        ),
                      ),
                    ),
                  ),
                );
              }),

              // Tab Item Buttons
              Obx(() {
                final selectedIndex = controller.currentIndex.value;
                return Row(
                  children: List.generate(_navItems.length, (index) {
                    final item = _navItems[index];
                    final isSelected = index == selectedIndex;
                    final activeColor = context.appColors.primary;
                    final inactiveColor = context.appColors.textSecondary;

                    return Expanded(
                      child: GestureDetector(
                        onTap: () => controller.changeTab(index),
                        behavior: HitTestBehavior.opaque,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 4.h),
                            AnimatedScale(
                              scale: isSelected ? 1.12 : 1.0,
                              duration: const Duration(milliseconds: 200),
                              child: _buildIcon(
                                isSelected,
                                item,
                                isSelected ? activeColor : inactiveColor,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              item.label,
                              style: TextStyle(
                                color: isSelected ? activeColor : inactiveColor,
                                fontSize: 11.sp,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(bool isSelected, _BottomNavItem item, Color color) {
    if (item.svgIcon != null) {
      final svgAsset = isSelected
          ? (item.svgActiveIcon ?? item.svgIcon!)
          : item.svgIcon!;
      return SvgPicture.asset(
        svgAsset,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        width: 22.r,
        height: 22.r,
      );
    } else {
      final iconData = isSelected
          ? (item.activeIcon ?? item.icon!)
          : item.icon!;
      return Icon(iconData, color: color, size: 22.r);
    }
  }
}
