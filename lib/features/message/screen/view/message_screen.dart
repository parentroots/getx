import 'package:flutter/material.dart';
import 'package:getx_template/component/app_bar/common_app_bar.dart';
import 'package:getx_template/component/layout/common_scaffold.dart';
import 'package:getx_template/component/states/empty_state_widget.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CommonScaffold(
      appBar: CommonAppBar(
        title: 'Messages',
        showBack: false,
      ),
      body: Center(

        child: EmptyStateWidget(
          title: 'No Messages',

          message: 'Your conversations will appear here.',
        ),
      ),
    );
  }
}
