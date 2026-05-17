import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/app_app_bar.dart';
import 'package:getx_template/component/layout/responsive_scaffold.dart';
import 'package:getx_template/component/states/empty_state_widget.dart';
import 'package:getx_template/features/notifications/screen/controller/notifications_controller.dart';

class NotificationScreen extends GetView<NotificationsController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveScaffold(
      appBar: AppTopBar(title: 'Notifications'),
      body: EmptyStateWidget(
        title: 'No notifications',
        message:
            'Push and in-app notifications can be connected through NotificationService.',
      ),
    );
  }
}
