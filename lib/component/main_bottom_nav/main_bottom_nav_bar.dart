import 'dart:ui';
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
      // If you want to use SVG, you can do:
      // svgIcon: 'assets/icons/profile.svg',
      // svgActiveIcon: 'assets/icons/profile_active.svg',
    ),
    _BottomNavItem(
      icon: Icons.person_2_outlined,
      activeIcon: Icons.person,
      label: 'Profile',
    ),

  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final controller = Get.find<MainBottomNavController>();

    return SafeArea(
      bottom: true,
      child: Container(
        height: 64.h,
        margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 12.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: isDark ? 0.3 : 0.06,
              ),
              blurRadius: 20.r,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10,
            ),
            child: Obx(() {
              final selectedIndex =
                  controller.currentIndex.value;
              return Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                children: List.generate(_navItems.length, (
                  index,
                ) {
                  final item = _navItems[index];
                  final isSelected = index == selectedIndex;
                  final iconColor = isSelected
                      ? context.appColors.primary
                      : context.appColors.textSecondary;

                  return GestureDetector(
                    onTap: () =>
                        controller.changeTab(index),
                    behavior: HitTestBehavior.opaque,
                    child: AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 250,
                      ),
                      curve: Curves.easeInOut,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (isDark
                                  ? context.appColors.primary
                                        .withValues(alpha: 0.15)
                                  : context.appColors.primary
                                        .withValues(alpha: 0.08))
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(
                          16.r,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildIcon(
                            isSelected,
                            item,
                            iconColor,
                          ),
                          AnimatedSize(
                            duration: const Duration(
                              milliseconds: 200,
                            ),
                            curve: Curves.easeInOut,
                            child: isSelected
                                ? Padding(
                                    padding:
                                        EdgeInsets.only(
                                          left: 8.w,
                                        ),
                                    child: Text(
                                      item.label,
                                      style: TextStyle(
                                        color: context.appColors.primary,
                                        fontSize: 13.sp,
                                        fontWeight:
                                            FontWeight.w600,
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
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(
    bool isSelected,
    _BottomNavItem item,
    Color color,
  ) {
    if (item.svgIcon != null) {
      final svgAsset = isSelected
          ? (item.svgActiveIcon ?? item.svgIcon!)
          : item.svgIcon!;
      return SvgPicture.asset(
        svgAsset,
        colorFilter: ColorFilter.mode(
          color,
          BlendMode.srcIn,
        ),
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
