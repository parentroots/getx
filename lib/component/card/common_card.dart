import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_template/core/theme/app_spacing.dart';
import 'package:getx_template/utils/extensions/context_extensions.dart';

class CommonCard extends StatelessWidget {
  const CommonCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.shadowColor,
    this.surfaceTintColor,
    this.elevation,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.shape,
    this.clipBehavior,
    this.width,
    this.height,
    this.gradient,
    this.onTap,
    this.onLongPress,
    this.splashColor,
  });

  // ─── Content ─────────────────────────────────
  final Widget child;
  final EdgeInsetsGeometry? padding;

  // ─── Styling & Colors ────────────────────────
  final Color? color;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final double? elevation;
  final Gradient? gradient;

  // ─── Borders & Shape ─────────────────────────
  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final ShapeBorder? shape;
  final Clip? clipBehavior;

  // ─── Size & Margins ──────────────────────────
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;

  // ─── Interaction ─────────────────────────────
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Color? splashColor;

  @override
  Widget build(BuildContext context) {
    final isClickable = onTap != null || onLongPress != null;

    // ── Resolve padding & borders ──────────────
    final defaultPadding = EdgeInsets.all(AppSpacing.md.r);
    final resolvedRadius = BorderRadius.circular((borderRadius ?? 12.0).r);

    final resolvedShape = shape ??
        RoundedRectangleBorder(
          borderRadius: resolvedRadius,
          side: borderColor != null
              ? BorderSide(
                  color: borderColor!,
                  width: (borderWidth ?? 1.0).r,
                )
              : BorderSide.none,
        );

    // ── Build content with tap handlers ─────────
    Widget content = Padding(
      padding: padding ?? defaultPadding,
      child: child,
    );

    if (isClickable) {
      final inkBorderRadius = resolvedShape is RoundedRectangleBorder
          ? resolvedShape.borderRadius
          : resolvedRadius;

      content = InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: inkBorderRadius is BorderRadius ? inkBorderRadius : resolvedRadius,
        splashColor: splashColor,
        child: content,
      );
    }

    // ── Apply gradient background if provided ────
    if (gradient != null) {
      final inkBorderRadius = resolvedShape is RoundedRectangleBorder
          ? resolvedShape.borderRadius
          : resolvedRadius;

      content = Ink(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: inkBorderRadius,
        ),
        child: content,
      );
    }

    // ── Build final Card ─────────────────────────
    return Card(
      color: gradient != null ? context.appColors.transparent : color,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      elevation: elevation,
      margin: margin,
      shape: resolvedShape,
      clipBehavior: clipBehavior ?? (isClickable ? Clip.antiAlias : Clip.none),
      child: SizedBox(
        width: width?.w,
        height: height?.h,
        child: content,
      ),
    );
  }
}
