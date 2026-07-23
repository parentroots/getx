import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_template/utils/extensions/context_extensions.dart';

/// A premium, highly customizable rating bar component.
/// Supports both interactive rating selection and static read-only star previews
/// with pixel-accurate half/fractional star configurations and smooth drag interactions.
class CommonRatingBar extends StatefulWidget {
  const CommonRatingBar({
    super.key,
    required this.rating,
    this.onRatingChanged,
    this.itemCount = 5,
    this.size = 24.0,
    this.spacing = 4.0,
    this.filledColor = Colors.amber,
    this.unfilledColor = const Color(0xFFE0E0E0),
    this.filledIcon = Icons.star_rounded,
    this.unfilledIcon = Icons.star_border_rounded,
    this.allowHalf = true,
  });

  /// The active rating count (can be double, e.g. 4.5).
  final double rating;

  /// Callback when a rating is selected. If null, the bar behaves as READ-ONLY.
  final ValueChanged<double>? onRatingChanged;

  /// Total number of rating icons (defaults to 5).
  final int itemCount;

  /// Size of each rating icon (defaults to 24.0).
  final double size;

  /// Spacing between each rating icon.
  final double spacing;

  /// Color of a filled/active rating icon.
  final Color filledColor;

  /// Color of an unfilled/inactive rating icon.
  final Color unfilledColor;

  /// Icon data for active segments.
  final IconData filledIcon;

  /// Icon data for inactive segments.
  final IconData unfilledIcon;

  /// Whether to allow half-rating selection/gestures (defaults to true).
  final bool allowHalf;

  @override
  State<CommonRatingBar> createState() => _CommonRatingBarState();
}

class _CommonRatingBarState extends State<CommonRatingBar> {
  double? _dragRating;

  bool get isReadOnly => widget.onRatingChanged == null;

  void _handleTouch(double dx, double totalWidth) {
    if (isReadOnly) return;

    double value = 0.0;
    double accumulatedWidth = 0.0;
    final size = widget.size.r;
    final spacing = widget.spacing.w;

    for (int i = 0; i < widget.itemCount; i++) {
      final starStart = accumulatedWidth;
      final starEnd = starStart + size;

      if (dx >= starStart && dx <= starEnd) {
        final percent = (dx - starStart) / size;
        if (widget.allowHalf) {
          value = i.toDouble() + (percent < 0.5 ? 0.5 : 1.0);
        } else {
          value = i.toDouble() + 1.0;
        }
        break;
      } else if (dx > starEnd && dx < starEnd + spacing) {
        value = i.toDouble() + 1.0;
        break;
      }
      accumulatedWidth += size + spacing;
    }

    if (dx >= totalWidth) {
      value = widget.itemCount.toDouble();
    } else if (dx <= 0) {
      value = 0.0;
    }

    if (value != _dragRating) {
      setState(() {
        _dragRating = value;
      });
      widget.onRatingChanged?.call(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeRating = _dragRating ?? widget.rating;
    final size = widget.size.r;
    final spacing = widget.spacing.w;
    final totalWidth = widget.itemCount * size + (widget.itemCount - 1) * spacing;

    final resolvedFilledColor = widget.filledColor == Colors.amber ? context.appColors.warning : widget.filledColor;
    final resolvedUnfilledColor = widget.unfilledColor == const Color(0xFFE0E0E0) ? context.appColors.border : widget.unfilledColor;

    Widget ratingBar = Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.itemCount, (index) {
        final double indexValue = index.toDouble();
        Widget iconWidget;
        bool isFilled = false;

        // Determine fraction filled
        if (activeRating >= indexValue + 1) {
          isFilled = true;
          iconWidget = Icon(widget.filledIcon, size: size, color: resolvedFilledColor);
        } else if (activeRating > indexValue) {
          final double fraction = activeRating - indexValue;
          isFilled = fraction >= 0.5;
          iconWidget = Stack(
            children: [
              Icon(widget.unfilledIcon, size: size, color: resolvedUnfilledColor),
              ClipRect(
                clipper: _FractionalClipper(fraction),
                child: Icon(widget.filledIcon, size: size, color: resolvedFilledColor),
              ),
            ],
          );
        } else {
          iconWidget = Icon(widget.unfilledIcon, size: size, color: resolvedUnfilledColor);
        }

        // Star item wrapped with scale transition if interactive
        final starItem = isReadOnly
            ? iconWidget
            : _RatingStar(
                isFilled: isFilled,
                child: iconWidget,
              );

        return Padding(
          padding: EdgeInsets.only(
            right: index < widget.itemCount - 1 ? spacing : 0,
          ),
          child: starItem,
        );
      }),
    );

    if (isReadOnly) return ratingBar;

    return GestureDetector(
      onTapDown: (details) => _handleTouch(details.localPosition.dx, totalWidth),
      onHorizontalDragUpdate: (details) => _handleTouch(details.localPosition.dx, totalWidth),
      onHorizontalDragEnd: (_) => setState(() => _dragRating = null),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: ratingBar,
      ),
    );
  }
}

/// A micro-animated wrapper that pops/bounces a rating star when filled.
class _RatingStar extends StatefulWidget {
  const _RatingStar({
    required this.isFilled,
    required this.child,
  });

  final bool isFilled;
  final Widget child;

  @override
  State<_RatingStar> createState() => _RatingStarState();
}

class _RatingStarState extends State<_RatingStar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.25)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.25, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_controller);

    if (widget.isFilled) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant _RatingStar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFilled && !oldWidget.isFilled) {
      _controller.reset();
      _controller.forward();
    } else if (!widget.isFilled && oldWidget.isFilled) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: widget.child,
    );
  }
}

/// Custom clipper to show fractional icons.
class _FractionalClipper extends CustomClipper<Rect> {
  _FractionalClipper(this.fraction);

  final double fraction;

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0.0, 0.0, size.width * fraction, size.height);
  }

  @override
  bool shouldReclip(covariant _FractionalClipper oldClipper) {
    return oldClipper.fraction != fraction;
  }
}
