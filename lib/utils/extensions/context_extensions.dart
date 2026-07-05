import 'package:flutter/material.dart';

/// A set of premium, high-readability extensions on [BuildContext]
/// to write clean, concise layout code.
extension ContextExtensions on BuildContext {
  /// Quick access to the [ThemeData] of the current context.
  ThemeData get theme => Theme.of(this);

  /// Quick access to the [ColorScheme] of the current context.
  ColorScheme get colorScheme => theme.colorScheme;

  /// Quick access to the color scheme colors.
  ColorScheme get colors => theme.colorScheme;

  /// Quick access to the [TextTheme] of the current context.
  TextTheme get textTheme => theme.textTheme;

  /// Quick access to the current device screen size.
  /// Using sizeOf(this) avoids rebuilding the widget if size didn't change.
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Quick access to the current device screen width.
  double get screenWidth => screenSize.width;

  /// Quick access to the current device screen height.
  double get screenHeight => screenSize.height;

  /// Check if dark mode is active.
  bool get isDarkMode => theme.brightness == Brightness.dark;
}
