import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/modules/system/controllers/system_controller.dart';
import 'package:getx_template/widgets/app_app_bar.dart';
import 'package:getx_template/widgets/layout/responsive_scaffold.dart';
import 'package:getx_template/widgets/states/error_state_widget.dart';

class ErrorScreen extends GetView<SystemController> {
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
      appBar: const AppTopBar(title: 'Error'),
      body: ErrorStateWidget(
        title: title,
        message: message,
        onRetry: () => Get.back<void>(),
      ),
    );
  }
}
