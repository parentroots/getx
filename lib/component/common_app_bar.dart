import 'package:flutter/material.dart';
import 'package:getx_template/component/layout/common_text.dart';

class CommonTopBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonTopBar({
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
      title: CommonText(
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
