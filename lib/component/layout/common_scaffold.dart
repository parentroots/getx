import 'package:flutter/material.dart';
import 'package:getx_template/core/theme/app_dimensions.dart';
import 'package:getx_template/core/theme/app_spacing.dart';

class CommonScaffold extends StatelessWidget {
  const CommonScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.drawer,
    this.safeArea = true,
    this.padding = const EdgeInsets.all(AppSpacing.md),
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final bool safeArea;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final content = Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppDimensions.desktopContentWidth,
        ),
        child: Padding(padding: padding, child: body),
      ),
    );

    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      body: safeArea ? SafeArea(child: content) : content,
    );
  }
}
