import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_template/core/constants/app_colors.dart';

/// A premium, highly customizable, and animated toggle switch widget.
/// Featuring elastic iOS-style thumb stretching, custom inner icons,
/// haptic feedback, and disabled state handling.
class CommonSwitch extends StatefulWidget {
  const CommonSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor = Colors.white,
    this.activeThumbColor,
    this.width,
    this.height,
    this.enableHaptic = true,
    this.activeThumbIcon,
    this.inactiveThumbIcon,
  });

  /// The active state status of the toggle.
  final bool value;

  /// Callback when toggle is clicked. If null, the switch behaves as disabled.
  final ValueChanged<bool>? onChanged;

  /// The track background color when active.
  final Color? activeColor;

  /// The track background color when inactive.
  final Color? inactiveColor;

  /// The color of the sliding toggle wheel/thumb.
  final Color thumbColor;

  /// Custom color for the thumb when active.
  final Color? activeThumbColor;

  /// Custom width of the toggle track (defaults to 42.w).
  final double? width;

  /// Custom height of the toggle track (defaults to 22.h).
  final double? height;

  /// Trigger haptic feedback on toggle change.
  final bool enableHaptic;

  /// Optional widget/icon displayed inside the thumb when active.
  final Widget? activeThumbIcon;

  /// Optional widget/icon displayed inside the thumb when inactive.
  final Widget? inactiveThumbIcon;

  @override
  State<CommonSwitch> createState() => _CommonSwitchState();
}

class _CommonSwitchState extends State<CommonSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _positionAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _positionAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    if (widget.value) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(covariant CommonSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    if (widget.onChanged == null) return;
    if (widget.enableHaptic) {
      HapticFeedback.lightImpact();
    }
    widget.onChanged!(!widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isEnabled = widget.onChanged != null;

    final double resolvedWidth = widget.width ?? 42.w;
    final double resolvedHeight = widget.height ?? 22.h;
    final double resolvedThumbSize = resolvedHeight - 4.r;
    final double maxMove = resolvedWidth - resolvedThumbSize - 6.r;

    final Color resolvedActiveColor = widget.activeColor ?? AppColors.primaryColor;
    final Color resolvedInactiveColor = widget.inactiveColor ??
        (isDark ? Colors.grey.shade800 : Colors.grey.shade300);

    return GestureDetector(
      onTap: _onTap,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.5,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final t = _positionAnimation.value;

            // Elastic stretching: thumb gets wider in the middle of transition
            final double stretch = 1.0 - (t - 0.5).abs() * 2.0; // 0.0 -> 1.0 -> 0.0
            final double currentThumbWidth = resolvedThumbSize + (stretch * 8.r);

            final trackColor = Color.lerp(resolvedInactiveColor, resolvedActiveColor, t);
            final currentThumbColor = Color.lerp(
              widget.thumbColor,
              widget.activeThumbColor ?? widget.thumbColor,
              t,
            )!;

            final double baseLeft = 3.r;
            final double moveDistance = t * maxMove;
            final double leftOffset = baseLeft + moveDistance - (currentThumbWidth - resolvedThumbSize) * (t >= 0.5 ? 1.0 : 0.0);

            Widget? thumbChild;
            if (widget.activeThumbIcon != null || widget.inactiveThumbIcon != null) {
              thumbChild = Opacity(
                opacity: 1.0,
                child: t >= 0.5 ? widget.activeThumbIcon : widget.inactiveThumbIcon,
              );
            }

            return Container(
              width: resolvedWidth,
              height: resolvedHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(resolvedHeight / 2),
                color: trackColor,
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: leftOffset,
                    top: 3.r,
                    child: Container(
                      width: currentThumbWidth,
                      height: resolvedThumbSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(resolvedThumbSize / 2),
                        color: currentThumbColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 4.r,
                            offset: Offset(0, 2.r),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: thumbChild,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
