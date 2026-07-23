import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/layout/common_text.dart';
import 'package:getx_template/core/config/app_config.dart';
import 'package:getx_template/core/theme/app_spacing.dart';
import 'package:getx_template/features/splash/screen/controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Accessing the controller here triggers its lazy instantiation,
    // which automatically runs onReady() -> _bootstrap() routing.
    final _ = controller;
    final appName = Get.find<AppConfig>().appName;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 84.w,
                height: 84.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Icon(
                  Icons.layers_rounded,
                  size: 42.r,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: AppSpacing.lg.h),
              CommonText(
                appName,
                style: context.textTheme.headlineMedium,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSpacing.md.h),
              SizedBox.square(
                dimension: 24.r,
                child: const CircularProgressIndicator(strokeWidth: 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
