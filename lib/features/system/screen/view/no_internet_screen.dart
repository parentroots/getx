import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/app_bar/common_app_bar.dart';
import 'package:getx_template/component/layout/common_scaffold.dart';
import 'package:getx_template/component/states/no_internet_widget.dart';
import 'package:getx_template/features/system/screen/controller/system_controller.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SystemController>();
    return CommonScaffold(
      appBar: const CommonAppBar(title: 'No internet'),
      body: NoInternetWidget(onRetry: controller.retryConnection),
    );
  }
}
