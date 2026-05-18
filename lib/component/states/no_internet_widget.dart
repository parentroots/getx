import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_template/component/common_button.dart';
import 'package:getx_template/component/layout/common_text.dart';

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
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 16.h),
            CommonText(
              'No internet connection',
              variant: TextVariant.title,
              weight: TextWeight.bold,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            const CommonText(
              'Check your connection and try again.',
              variant: TextVariant.body,
              textAlign: TextAlign.center,
              color: Colors.grey,
            ),
            if (onRetry != null) ...[
              SizedBox(height: 24.h),
              CommonButton(
                label: 'Retry',
                icon: const Icon(Icons.refresh),
                onPressed: onRetry,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
