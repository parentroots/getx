import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/component/layout/app_text.dart';
import 'package:getx_template/core/config/app_config.dart';
import 'package:getx_template/core/routing/app_routes.dart';
import 'package:getx_template/core/theme/app_spacing.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(AppRoutes.login);
    });
  }
  @override
  Widget build(BuildContext context) {
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
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: AppSpacing.lg.h),
              AppText(
                appName,
                variant: TextVariant.header,
                weight: TextWeight.bold,
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
