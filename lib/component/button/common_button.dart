import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_template/utils/constants/app_colors.dart';
import 'package:getx_template/utils/extensions/context_extensions.dart';


class CommonButton extends StatefulWidget {
  const CommonButton({
    required this.titleText,
    super.key,
    this.onTap,
    this.titleColor,
    this.buttonColor,
    this.titleSize,
    this.buttonRadius,
    this.alignment = MainAxisAlignment.center,
    this.titleWeight,
    this.buttonHeight,
    this.borderWidth,
    this.isLoading = false,
    this.buttonWidth,
    this.borderColor,
    this.prefix,
    this.suffix,
    this.elevation,
    this.gradient,
    this.padding,
    this.titleGradient,
    this.titleSpacing = 0.5,
    this.border = false,
    this.isEnabled = true,
  });

  final VoidCallback? onTap;
  final String titleText;
  final Color? titleColor;
  final Color? buttonColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? titleSize;
  final FontWeight? titleWeight;
  final double? buttonRadius;
  final double? buttonHeight;
  final double? buttonWidth;
  final bool isLoading;
  final Widget? prefix;
  final Widget? suffix;
  final MainAxisAlignment alignment;
  final double? elevation;
  final Gradient? gradient;
  final Gradient? titleGradient;
  final EdgeInsetsGeometry? padding;
  final double titleSpacing;
  final bool border;
  final bool isEnabled;

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.linear),
    );

    if (widget.isLoading) {
      _animationController.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant CommonButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading != oldWidget.isLoading) {
      if (widget.isLoading) {
        _animationController.repeat();
      } else {
        _animationController.stop();
        _animationController.reset();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color resolvedBackgroundColor = widget.buttonColor ?? context.appColors.primary;
    final Color resolvedTitleColor = widget.titleColor ?? Colors.white;
    final Color resolvedBorderColor = widget.borderColor ??
        (widget.border ? const Color(0xFF16C3C1) : Colors.transparent);
    final double resolvedBorderWidth =
        widget.borderWidth ?? (widget.border ? 1.0 : 0.0);
    final double resolvedRadius = widget.buttonRadius ?? 8.0;
    final double resolvedHeight = widget.buttonHeight ?? 50.0;
    final double resolvedElevation = widget.elevation ?? 2.0;
    final EdgeInsets resolvedPadding = (widget.padding ??
        const EdgeInsets.symmetric(horizontal: 14, vertical: 10))
        .resolve(Directionality.of(context));
    final bool canTap = widget.isEnabled && !widget.isLoading;

    final TextStyle textStyle = TextStyle(
      fontSize: (widget.titleSize ?? 16).sp,
      fontWeight: widget.titleWeight ?? FontWeight.w600,
      letterSpacing: widget.titleSpacing,
      color: resolvedTitleColor,
    );

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bool hasBoundedWidth = constraints.maxWidth.isFinite;
            final double minRequiredWidth = _measureMinWidth(
              textStyle: textStyle,
              padding: resolvedPadding,
            );
            final double requestedWidth = widget.buttonWidth ?? double.nan;
            double? calculatedWidth;

            final double safeMin = minRequiredWidth > constraints.maxWidth ? constraints.maxWidth : minRequiredWidth;

            if (requestedWidth == double.infinity) {
              calculatedWidth = hasBoundedWidth ? constraints.maxWidth : null;
            } else if (!requestedWidth.isNaN) {
              calculatedWidth = hasBoundedWidth
                  ? requestedWidth.clamp(safeMin, constraints.maxWidth)
                  : requestedWidth;
            } else {
              calculatedWidth = hasBoundedWidth
                  ? minRequiredWidth.clamp(safeMin, constraints.maxWidth)
                  : minRequiredWidth;
            }

            return SizedBox(
              width: calculatedWidth,
              height: resolvedHeight,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ElevatedButton(
                      onPressed: canTap ? widget.onTap : null,
                      style: ElevatedButton.styleFrom(
                        elevation: widget.isEnabled ? resolvedElevation : 0,
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        shadowColor: resolvedBackgroundColor.withValues(alpha: 0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(resolvedRadius),
                          side: BorderSide(
                            color: resolvedBorderColor,
                            width: resolvedBorderWidth,
                          ),
                        ),
                      ).copyWith(
                        overlayColor: WidgetStateProperty.all(Colors.transparent),
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          color: widget.gradient == null
                              ? (widget.isEnabled
                              ? resolvedBackgroundColor
                              : resolvedBackgroundColor.withValues(alpha: 0.5))
                              : null,
                          gradient: widget.gradient,
                          borderRadius: BorderRadius.circular(resolvedRadius),
                          border: Border.all(
                            color: resolvedBorderColor,
                            width: resolvedBorderWidth,
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          padding: resolvedPadding,
                          child: _buildContent(
                            textStyle: textStyle,
                            textColor: widget.isEnabled
                                ? resolvedTitleColor
                                : resolvedTitleColor.withValues(alpha: 0.65),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (widget.isLoading)
                    Positioned.fill(
                      child: IgnorePointer(
                        child: AnimatedBuilder(
                          animation: _animation,
                          builder: (_, __) => CustomPaint(
                            painter: _BorderLoaderPainter(
                              _animation.value,
                              resolvedTitleColor,
                              resolvedRadius,
                            ),
                          ),
                        ),
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

  Widget _buildContent({required TextStyle textStyle, required Color textColor}) {
    final Widget title = widget.titleGradient == null
        ? Text(
      widget.titleText,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: textStyle.copyWith(color: textColor),
    )
        : ShaderMask(
      shaderCallback: (Rect bounds) =>
          widget.titleGradient!.createShader(bounds),
      child: Text(
        widget.titleText,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: textStyle.copyWith(color: Colors.white),
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: widget.alignment,
      children: [
        if (widget.prefix != null) ...[
          widget.prefix!,
          const SizedBox(width: 8),
        ],
        Flexible(child: title),
        if (widget.suffix != null) ...[
          const SizedBox(width: 8),
          widget.suffix!,
        ],
      ],
    );
  }

  double _measureMinWidth({
    required TextStyle textStyle,
    required EdgeInsets padding,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: widget.titleText, style: textStyle),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();

    final double prefixWidth = widget.prefix != null ? 24.0 : 0.0;
    final double suffixWidth = widget.suffix != null ? 24.0 : 0.0;

    return textPainter.width +
        prefixWidth +
        suffixWidth +
        padding.left +
        padding.right;
  }
}

class _BorderLoaderPainter extends CustomPainter {
  _BorderLoaderPainter(this.progress, this.color, this.radius);

  final double progress;
  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));

    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const double dashWidth = 50.0;
    const double dashSpace = 1.0;
    const double totalLength = (dashWidth + dashSpace);
    final Iterable<PathMetric> pathMetrics = path.computeMetrics();

    for (final PathMetric metric in pathMetrics) {
      double distance = progress * metric.length;
      while (distance < metric.length) {
        final Path segment = metric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(segment, paint);
        distance += totalLength;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _BorderLoaderPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.radius != radius;
  }
}

