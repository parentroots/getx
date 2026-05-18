import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A premium, highly customizable, and animated toggle switch widget
/// designed to override standard, platform-dependent defaults.
class CommonSwitch extends StatelessWidget {
  const CommonSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor = Colors.white,
    this.width,
    this.height,
  });

  /// The active state status of the toggle.
  final bool value;

  /// Callback when toggle is clicked.
  final ValueChanged<bool> onChanged;

  /// The track background color when active.
  final Color? activeColor;

  /// The track background color when inactive.
  final Color? inactiveColor;

  /// The color of the sliding toggle wheel/thumb.
  final Color thumbColor;

  /// Custom width of the toggle track (defaults to 52.w).
  final double? width;

  /// Custom height of the toggle track (defaults to 28.h).
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final double resolvedWidth = width ?? 52.w;
    final double resolvedHeight = height ?? 28.h;
    final double resolvedThumbSize = resolvedHeight - 6.r;

    final Color resolvedActiveColor = activeColor ?? theme.primaryColor;
    final Color resolvedInactiveColor = inactiveColor ??
        (isDark ? Colors.grey.shade800 : Colors.grey.shade300);

    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: resolvedWidth,
        height: resolvedHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(resolvedHeight / 2),
          color: value ? resolvedActiveColor : resolvedInactiveColor,
        ),
        padding: EdgeInsets.symmetric(horizontal: 3.r),
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          width: resolvedThumbSize,
          height: resolvedThumbSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: thumbColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 4.r,
                offset: Offset(0, 2.r),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
