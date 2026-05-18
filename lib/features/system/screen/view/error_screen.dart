import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/common_app_bar.dart';
import 'package:getx_template/component/layout/responsive_scaffold.dart';
import 'package:getx_template/component/states/error_state_widget.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    super.key,
    this.title = 'Something went wrong',
    this.message = 'Please try again in a moment.',
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      appBar: const CommonTopBar(title: 'Error'),
      body: ErrorStateWidget(
        title: title,
        message: message,
        onRetry: () => Get.back<void>(),
      ),
    );
  }
}
