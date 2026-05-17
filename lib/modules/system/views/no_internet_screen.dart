import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/modules/system/controllers/system_controller.dart';
import 'package:getx_template/widgets/app_app_bar.dart';
import 'package:getx_template/widgets/layout/responsive_scaffold.dart';
import 'package:getx_template/widgets/states/no_internet_widget.dart';

class NoInternetScreen extends GetView<SystemController> {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaffold(
      appBar: const AppTopBar(title: 'No internet'),
      body: NoInternetWidget(onRetry: controller.retryConnection),
    );
  }
}
