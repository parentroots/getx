import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ResponsiveSizedBoxExtension on num {
  /// Returns a responsive SizedBox with this value as height (using screenutil .h)
  SizedBox get height => SizedBox(height: h);

  /// Returns a responsive SizedBox with this value as width (using screenutil .w)
  SizedBox get width => SizedBox(width: w);
}
