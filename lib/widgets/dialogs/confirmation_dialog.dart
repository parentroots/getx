import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
  });

  final String title;
  final String message;
  final String confirmText;
  final String cancelText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Get.back<bool>(result: false),
          child: Text(cancelText),
        ),
        FilledButton(
          onPressed: () => Get.back<bool>(result: true),
          child: Text(confirmText),
        ),
      ],
    );
  }
}
