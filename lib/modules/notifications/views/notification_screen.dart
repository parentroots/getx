import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/modules/notifications/controllers/notifications_controller.dart';
import 'package:getx_template/widgets/app_app_bar.dart';
import 'package:getx_template/widgets/layout/responsive_scaffold.dart';
import 'package:getx_template/widgets/states/empty_state_widget.dart';

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
