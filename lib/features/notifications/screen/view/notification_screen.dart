import 'package:flutter/material.dart';
import 'package:getx_template/component/common_app_bar.dart';
import 'package:getx_template/component/layout/common_scaffold.dart';
import 'package:getx_template/component/states/empty_state_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CommonScaffold(
      appBar: CommonAppBar(title: 'Notifications'),
      body: EmptyStateWidget(
        title: 'No notifications',
        message:
            'Push and in-app notifications can be connected through NotificationService.',
      ),
    );
  }
}
