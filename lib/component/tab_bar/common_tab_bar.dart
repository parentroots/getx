import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_template/component/layout/common_text.dart';

/// Selection styling options for the tab bar indicator.
enum CommonTabStyle {
  pill,      // Sliding pill selector background
  underline, // Inset underline indicator
}

/// A structured model for tab items supporting icons and badges.
class CommonTabItem {
  const CommonTabItem({
    required this.label,
    this.icon,
    this.badge,
    this.badgeColor,
  });

  final String label;
  final Widget? icon;
  final String? badge;
  final Color? badgeColor;
}

/// A premium, highly customizable, and animated sliding tab selector.
/// Perfect for switching categories, toggling filter statuses, or tab navigation.
class CommonTabBar extends StatelessWidget {
  const CommonTabBar({
    super.key,
    this.tabs,
    this.tabItems,
    required this.selectedIndex,
    required this.onTabChanged,
    this.height = 46.0,
    this.borderRadius = 12.0,
    this.backgroundColor,
    this.indicatorColor,
    this.activeTextColor,
    this.inactiveTextColor,
    this.borderColor,
    this.borderWidth,
    this.padding,
    this.tabStyle = CommonTabStyle.pill,
    this.enableHaptic = true,
  }) : assert(tabs != null || tabItems != null, 'Either tabs or tabItems must be provided.');

  /// The list of tab titles as simple strings (for backward compatibility).
  final List<String>? tabs;

  /// The list of tab items supporting icons and badges.
  final List<CommonTabItem>? tabItems;

  /// The current active tab index.
  final int selectedIndex;

  /// Callback when a tab is clicked.
  final ValueChanged<int> onTabChanged;

  /// Total height of the tab bar (defaults to 46.h).
  final double height;

  /// Corner radius of the tab bar (defaults to 12.r).
  final double borderRadius;

  /// Background color of the tab bar container.
  final Color? backgroundColor;

  /// Color of the active sliding indicator background.
  final Color? indicatorColor;

  /// Color of active tab title text.
  final Color? activeTextColor;

  /// Color of inactive tab title text.
  final Color? inactiveTextColor;

  /// Outline track border color.
  final Color? borderColor;

  /// Outline track border width.
  final double? borderWidth;

  /// Outer padding of the tab bar.
  final EdgeInsetsGeometry? padding;

  /// Selection styling (pill or underline, defaults to pill).
  final CommonTabStyle tabStyle;

  /// Trigger haptic feedback click.
  final bool enableHaptic;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Resolve list of items (backward compatible with tabs list)
    final List<CommonTabItem> resolvedItems = tabItems ??
        tabs!.map((t) => CommonTabItem(label: t)).toList();
    final tabsLength = resolvedItems.length;

    final resolvedBgColor = backgroundColor ??
        (isDark ? Colors.grey.shade900 : Colors.grey.shade100);
    
    final trackBgColor = tabStyle == CommonTabStyle.underline
        ? (backgroundColor ?? Colors.transparent)
        : resolvedBgColor;

    final resolvedIndicatorColor = indicatorColor ??
        (isDark ? Colors.grey.shade800 : Colors.white);
    
    final resolvedActiveTextColor = activeTextColor ?? theme.primaryColor;
    
    final resolvedInactiveTextColor = inactiveTextColor ??
        (isDark ? Colors.grey.shade500 : Colors.grey.shade600);

    final Border? trackBorder = borderColor != null
        ? Border.all(color: borderColor!, width: (borderWidth ?? 1.0).r)
        : null;

    Widget tabContainer = Container(
      height: height.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: trackBgColor,
        borderRadius: BorderRadius.circular(borderRadius.r),
        border: trackBorder,
      ),
      padding: EdgeInsets.all(tabStyle == CommonTabStyle.underline ? 0 : 4.r),
      child: Stack(
        children: [
          // Smooth sliding active indicator with springy slide animation
          if (tabsLength > 0)
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutBack, // Springy snap slide
              alignment: Alignment(
                tabsLength <= 1 ? 0.0 : -1.0 + (selectedIndex * (2.0 / (tabsLength - 1))),
                tabStyle == CommonTabStyle.underline ? 1.0 : 0.0,
              ),
              child: FractionallySizedBox(
                widthFactor: 1 / tabsLength,
                child: tabStyle == CommonTabStyle.underline
                    ? Container(
                        height: 3.h,
                        margin: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: resolvedActiveTextColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(3.r),
                            topRight: Radius.circular(3.r),
                          ),
                        ),
                      )
                    : Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: resolvedIndicatorColor,
                          borderRadius: BorderRadius.circular((borderRadius - 3).r),
                          boxShadow: isDark
                              ? []
                              : [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.06),
                                    blurRadius: 6.r,
                                    offset: Offset(0, 2.r),
                                  ),
                                ],
                        ),
                      ),
              ),
            ),

          // Tab Item Buttons
          Row(
            children: List.generate(tabsLength, (index) {
              final isSelected = index == selectedIndex;
              final item = resolvedItems[index];

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (enableHaptic) {
                      HapticFeedback.selectionClick();
                    }
                    onTabChanged(index);
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: _buildTabItemContent(
                      context: context,
                      item: item,
                      isSelected: isSelected,
                      activeColor: resolvedActiveTextColor,
                      inactiveColor: resolvedInactiveTextColor,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );

    return padding != null
        ? Padding(padding: padding!, child: tabContainer)
        : tabContainer;
  }

  Widget _buildTabItemContent({
    required BuildContext context,
    required CommonTabItem item,
    required bool isSelected,
    required Color activeColor,
    required Color inactiveColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (item.icon != null) ...[
          IconTheme(
            data: IconThemeData(
              color: isSelected ? activeColor : inactiveColor,
              size: 18.r,
            ),
            child: item.icon!,
          ),
          SizedBox(width: 6.w),
        ],
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            color: isSelected ? activeColor : inactiveColor,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
          child: CommonText(
            item.label,
            variant: TextVariant.body,
            weight: isSelected ? TextWeight.bold : TextWeight.medium,
            color: isSelected ? activeColor : inactiveColor,
          ),
        ),
        if (item.badge != null) ...[
          SizedBox(width: 6.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: item.badgeColor ?? Colors.red,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              item.badge!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
