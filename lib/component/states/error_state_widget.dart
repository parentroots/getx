import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_template/component/button/common_button.dart';
import 'package:getx_template/component/layout/common_text.dart';
import 'package:getx_template/utils/extensions/context_extensions.dart';

class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({
    super.key,
    this.title = 'Something went wrong',
    this.message = 'Please try again in a moment.',
    this.onRetry,
  });

  final String title;
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 420.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48.r,
              color: context.appColors.error,
            ),
            SizedBox(height: 16.h),
            CommonText(
              title,
              variant: TextVariant.title,
              weight: TextWeight.bold,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            CommonText(
              message,
              variant: TextVariant.body,
              textAlign: TextAlign.center,
              color: context.appColors.textColor,
            ),
            if (onRetry != null) ...[
              SizedBox(height: 24.h),
              CommonButton(
                onTap: onRetry,
                titleText: "Retry",
              ),
            ],
          ],
        ),
      ),
    );
  }
}
