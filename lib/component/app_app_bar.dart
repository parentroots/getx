import 'package:flutter/material.dart';
import 'package:getx_template/component/layout/app_text.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.showBack = true,
  });

  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      automaticallyImplyLeading: showBack,
      title: AppText(
        title,
        variant: TextVariant.title,
        weight: TextWeight.bold,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
