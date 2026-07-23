import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_template/component/button/common_button.dart';
import 'package:getx_template/component/layout/common_text.dart';
import 'package:getx_template/utils/extensions/context_extensions.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key, this.onRetry});

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
              Icons.wifi_off_rounded,
              size: 56.r,
              color: context.appColors.primary,
            ),
            SizedBox(height: 16.h),
            CommonText(
              'No internet connection',
              style: context.textTheme.titleMedium,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            CommonText(
              'Check your connection and try again.',
              style: context.textTheme.bodyMedium,
              textAlign: TextAlign.center,
              color: context.appColors.textSecondary,
            ),
            if (onRetry != null) ...[
              SizedBox(height: 24.h),
              CommonButton(
                titleText:"",
                onTap: onRetry,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
