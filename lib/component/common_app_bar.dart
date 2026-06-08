import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getx_template/component/layout/common_text.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,

    // ─── Title ─────────────────────────────────
    this.title,
    this.titleWidget,
    this.titleVariant = TextVariant.title,
    this.titleWeight = TextWeight.bold,
    this.titleColor,
    this.titleFontSize,
    this.titleSpacing,
    this.centerTitle,

    // ─── Leading ───────────────────────────────
    this.leading,
    this.leadingWidth,
    this.showBack = true,

    // ─── Actions ───────────────────────────────
    this.actions,

    // ─── Appearance ────────────────────────────
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.scrolledUnderElevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.shape,

    // ─── Size & Padding ────────────────────────
    this.toolbarHeight,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.padding,

    // ─── Bottom (TabBar, etc.) ─────────────────
    this.bottom,

    // ─── System UI Overlay ─────────────────────
    this.systemOverlayStyle,

    // ─── Behavior ──────────────────────────────
    this.primary = true,
    this.excludeHeaderSemantics = false,
    this.forceMaterialTransparency = false,
    this.clipBehavior,
  });

  // ─── Title ─────────────────────────────────
  /// Simple string title — uses CommonText internally.
  final String? title;

  /// Custom title widget — overrides [title] when provided.
  final Widget? titleWidget;

  /// CommonText variant for the string title.
  final TextVariant titleVariant;

  /// CommonText weight for the string title.
  final TextWeight titleWeight;

  /// Title text color override.
  final Color? titleColor;

  /// Title font size override.
  final double? titleFontSize;

  /// Spacing between leading and title.
  final double? titleSpacing;

  /// Whether the title is centered.
  final bool? centerTitle;

  // ─── Leading ───────────────────────────────
  /// Custom leading widget (replaces default back button).
  final Widget? leading;

  /// Width of the leading widget area.
  final double? leadingWidth;

  /// If true and no leading is provided, shows back button when there's history.
  final bool showBack;

  // ─── Actions ───────────────────────────────
  /// Trailing action widgets.
  final List<Widget>? actions;

  // ─── Appearance ────────────────────────────
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final double? scrolledUnderElevation;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final ShapeBorder? shape;

  // ─── Size & Padding ────────────────────────
  /// Custom toolbar height (defaults to kToolbarHeight).
  final double? toolbarHeight;

  final TextStyle? toolbarTextStyle;
  final TextStyle? titleTextStyle;

  /// Extra padding around the AppBar content.
  final EdgeInsetsGeometry? padding;

  // ─── Bottom (TabBar, etc.) ─────────────────
  /// Widget to display below the AppBar (e.g. TabBar).
  final PreferredSizeWidget? bottom;

  // ─── System UI ─────────────────────────────
  /// Controls status bar brightness/icons.
  final SystemUiOverlayStyle? systemOverlayStyle;

  // ─── Behavior ──────────────────────────────
  final bool primary;
  final bool excludeHeaderSemantics;
  final bool forceMaterialTransparency;
  final Clip? clipBehavior;

  @override
  Widget build(BuildContext context) {
    // Build the title widget
    final Widget? resolvedTitle = titleWidget ??
        (title != null
            ? CommonText(
                title!,
                variant: titleVariant,
                weight: titleWeight,
                color: titleColor,
                fontSize: titleFontSize,
              )
            : null);

    Widget appBar = AppBar(
      // Title
      title: resolvedTitle,
      centerTitle: centerTitle,
      titleSpacing: titleSpacing,
      titleTextStyle: titleTextStyle,

      // Leading
      leading: leading,
      leadingWidth: leadingWidth,
      automaticallyImplyLeading: showBack,

      // Actions
      actions: actions,

      // Appearance
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      elevation: elevation,
      scrolledUnderElevation: scrolledUnderElevation,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      shape: shape,

      // Size
      toolbarHeight: toolbarHeight ?? kToolbarHeight,
      toolbarTextStyle: toolbarTextStyle,

      // Bottom
      bottom: bottom,

      // System UI
      systemOverlayStyle: systemOverlayStyle,

      // Behavior
      primary: primary,
      excludeHeaderSemantics: excludeHeaderSemantics,
      forceMaterialTransparency: forceMaterialTransparency,
      clipBehavior: clipBehavior,
    );

    // Wrap with padding if provided
    if (padding != null) {
      appBar = Padding(padding: padding!, child: appBar);
    }

    return appBar;
  }

  @override
  Size get preferredSize {
    final barHeight = toolbarHeight ?? kToolbarHeight;
    final bottomHeight = bottom?.preferredSize.height ?? 0.0;
    return Size.fromHeight(barHeight + bottomHeight);
  }
}
