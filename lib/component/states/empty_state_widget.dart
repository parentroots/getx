import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_template/component/common_button.dart';
import 'package:getx_template/component/layout/common_text.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    this.title = 'Nothing here yet',
    this.message = 'Content will appear here when it becomes available.',
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return _StateShell(
      icon: Icons.inbox_outlined,
      title: title,
      message: message,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }
}

class _StateShell extends StatelessWidget {
  const _StateShell({
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 420.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48.r, color: Theme.of(context).colorScheme.primary),
            SizedBox(height: 16.h),
            CommonText(
              title,
              variant: TextVariant.title,
              weight: TextWeight.bold,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            CommonText(
              message,
              variant: TextVariant.body,
              textAlign: TextAlign.center,
              color: Colors.grey,
            ),
            if (actionLabel != null && onAction != null) ...[
              SizedBox(height: 24.h),
              CommonButton(label: actionLabel!, onPressed: onAction),
            ],
          ],
        ),
      ),
    );
  }
}
