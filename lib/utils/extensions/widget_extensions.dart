import 'package:flutter/widgets.dart';

/// A set of premium, high-readability extensions on [Widget]
/// to write clean, concise, and flat widget trees.
extension WidgetExtensions on Widget {
  /// Wraps the widget with padding on all sides.
  Widget paddingAll(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  /// Wraps the widget with symmetric padding.
  Widget paddingSymmetric({double horizontal = 0.0, double vertical = 0.0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  /// Wraps the widget with customized side padding.
  Widget paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      ),
      child: this,
    );
  }

  /// Controls the visibility of this widget dynamically.
  Widget visible(bool isVisible, {bool keepAlive = false}) {
    if (keepAlive) {
      return Visibility(
        visible: isVisible,
        child: this,
      );
    }
    return isVisible ? this : const SizedBox.shrink();
  }
}
