import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_template/component/loading/shimmer_box.dart';

/// A premium, highly customizable skeleton loading mockup card
/// used to show outstanding skeleton layouts during asynchronous data fetching.
class AppShimmerCard extends StatelessWidget {
  const AppShimmerCard({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 16.0,
    this.padding,
    this.showImage = true,
    this.imageHeight = 140.0,
    this.showAvatar = true,
    this.avatarRadius = 20.0,
    this.lineCount = 2,
  });

  /// Custom width of the card.
  final double? width;

  /// Custom height of the card.
  final double? height;

  /// Corner radius of the card frame (defaults to 16.0).
  final double borderRadius;

  /// Inner padding (defaults to 16.w).
  final EdgeInsetsGeometry? padding;

  /// Whether to render a simulated top image skeleton (defaults to true).
  final bool showImage;

  /// The height of the simulated top image skeleton.
  final double imageHeight;

  /// Whether to render a circular user avatar placeholder (defaults to true).
  final bool showAvatar;

  /// Radius of the circular avatar placeholder.
  final double avatarRadius;

  /// Number of text line skeleton bars to draw (defaults to 2).
  final int lineCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final resolvedPadding = padding ?? EdgeInsets.all(16.w);

    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.white,
        borderRadius: BorderRadius.circular(borderRadius.r),
        border: Border.all(
          color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
          width: 1.r,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top Image Area
          if (showImage) ...[
            ShimmerBox(
              height: imageHeight.h,
              borderRadius: borderRadius,
            ),
            SizedBox(height: 16.h),
          ],
          
          // Bottom Content Row
          Padding(
            padding: resolvedPadding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showAvatar) ...[
                  ShimmerBox(
                    width: (avatarRadius * 2).r,
                    height: (avatarRadius * 2).r,
                    borderRadius: avatarRadius,
                  ),
                  SizedBox(width: 12.w),
                ],
                
                // Skeleton text lines
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header line
                      ShimmerBox(
                        width: 140.w,
                        height: 16.h,
                        borderRadius: 4,
                      ),
                      SizedBox(height: 8.h),
                      
                      // Extra sub-lines
                      for (int i = 0; i < lineCount; i++) ...[
                        ShimmerBox(
                          width: (i == lineCount - 1) ? 100.w : double.infinity,
                          height: 12.h,
                          borderRadius: 4,
                        ),
                        if (i < lineCount - 1) SizedBox(height: 6.h),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A companion list utility to easily mock up a series of shimmering cards.
class AppShimmerList extends StatelessWidget {
  const AppShimmerList({
    super.key,
    this.itemCount = 3,
    this.padding = const EdgeInsets.all(16.0),
    this.spacing = 16.0,
    this.showImage = true,
  });

  /// The count of shimmer cards to render.
  final int itemCount;

  /// Outer padding of the list.
  final EdgeInsetsGeometry padding;

  /// Spacing between shimmer cards.
  final double spacing;

  /// Whether to render simulated top image skeletons in cards.
  final bool showImage;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: padding,
      itemCount: itemCount,
      separatorBuilder: (context, index) => SizedBox(height: spacing.h),
      itemBuilder: (context, index) => AppShimmerCard(showImage: showImage),
    );
  }
}
