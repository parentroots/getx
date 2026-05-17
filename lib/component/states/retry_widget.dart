import 'package:flutter/material.dart';
import 'package:getx_template/component/states/error_state_widget.dart';

class RetryWidget extends StatelessWidget {
  const RetryWidget({
    super.key,
    required this.onRetry,
    this.message = 'The request could not be completed.',
  });

  final VoidCallback onRetry;
  final String message;

  @override
  Widget build(BuildContext context) {
    return ErrorStateWidget(message: message, onRetry: onRetry);
  }
}
