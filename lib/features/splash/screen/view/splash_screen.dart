import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/core/config/app_config.dart';
import 'package:getx_template/core/theme/app_spacing.dart';
import 'package:getx_template/features/splash/screen/controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

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
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.layers_rounded,
                  size: 42,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(appName, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: AppSpacing.md),
              const SizedBox.square(
                dimension: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
