import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A premium, highly customizable rating bar component.
/// Supports both interactive rating selection and static read-only star previews
/// with pixel-accurate half/fractional star configurations.
class AppRatingBar extends StatelessWidget {
  const AppRatingBar({
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

  bool get isReadOnly => onRatingChanged == null;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(itemCount, (index) {
        final double indexValue = index.toDouble();
        Widget iconWidget;

        // Determine fraction filled
        if (rating >= indexValue + 1) {
          // Fully active star
          iconWidget = Icon(filledIcon, size: size.r, color: filledColor);
        } else if (rating > indexValue) {
          // Fractional / half-filled star (precision stacking using ClipRect!)
          final double fraction = rating - indexValue;
          iconWidget = Stack(
            children: [
              Icon(unfilledIcon, size: size.r, color: unfilledColor),
              ClipRect(
                clipper: _FractionalClipper(fraction),
                child: Icon(filledIcon, size: size.r, color: filledColor),
              ),
            ],
          );
        } else {
          // Fully inactive star
          iconWidget = Icon(unfilledIcon, size: size.r, color: unfilledColor);
        }

        // Return static or gesture-responsive icon item
        if (isReadOnly) {
          return Padding(
            padding: EdgeInsets.only(right: index < itemCount - 1 ? spacing.w : 0),
            child: iconWidget,
          );
        }

        return GestureDetector(
          onTapDown: (details) {
            final double tapPosition = details.localPosition.dx;
            final double iconPercent = tapPosition / size.r;
            
            double selectedValue = indexValue;
            if (allowHalf && iconPercent < 0.5) {
              selectedValue += 0.5;
            } else {
              selectedValue += 1.0;
            }
            
            onRatingChanged?.call(selectedValue);
          },
          child: Padding(
            padding: EdgeInsets.only(right: index < itemCount - 1 ? spacing.w : 0),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: iconWidget,
            ),
          ),
        );
      }),
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
