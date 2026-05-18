import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_template/component/layout/common_text.dart';

/// A premium, highly customizable animated sliding tab selector.
/// Perfect for switching categories, toggling filter statuses, or tab navigation.
class CommonTabBar extends StatelessWidget {
  const CommonTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
    this.height = 46.0,
    this.borderRadius = 12.0,
    this.backgroundColor,
    this.indicatorColor,
    this.activeTextColor,
    this.inactiveTextColor,
    this.padding,
  });

  /// The list of tab titles.
  final List<String> tabs;

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

  /// Outer padding of the tab bar.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final resolvedBgColor = backgroundColor ??
        (isDark ? Colors.grey.shade900 : Colors.grey.shade100);
    final resolvedIndicatorColor = indicatorColor ??
        (isDark ? Colors.grey.shade800 : Colors.white);
    final resolvedActiveTextColor = activeTextColor ?? theme.primaryColor;
    final resolvedInactiveTextColor = inactiveTextColor ??
        (isDark ? Colors.grey.shade500 : Colors.grey.shade600);

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Container(
        height: height.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: resolvedBgColor,
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
        padding: EdgeInsets.all(4.r),
        child: Stack(
          children: [
            // Smooth sliding active indicator
            if (tabs.isNotEmpty)
              AnimatedAlign(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment: Alignment(
                  -1.0 + (selectedIndex * (2.0 / (tabs.length - 1))),
                  0.0,
                ),
                child: FractionallySizedBox(
                  widthFactor: 1 / tabs.length,
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: resolvedIndicatorColor,
                      borderRadius: BorderRadius.circular((borderRadius - 3).r),
                      boxShadow: isDark
                          ? []
                          : [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 4.r,
                                offset: Offset(0, 2.r),
                              ),
                            ],
                    ),
                  ),
                ),
              ),

            // Tab Item Buttons
            Row(
              children: List.generate(tabs.length, (index) {
                final isSelected = index == selectedIndex;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onTabChanged(index),
                    behavior: HitTestBehavior.opaque,
                    child: Center(
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          color: isSelected
                              ? resolvedActiveTextColor
                              : resolvedInactiveTextColor,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        child: CommonText(
                          tabs[index],
                          variant: TextVariant.body,
                          weight: isSelected ? TextWeight.bold : TextWeight.regular,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
