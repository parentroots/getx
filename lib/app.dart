import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_template/core/bindings/dependency_injection.dart';
import 'package:getx_template/core/config/app_config.dart';
import 'package:getx_template/core/routing/app_routes.dart';
import 'package:getx_template/core/theme/app_theme.dart';
import 'package:getx_template/utils/app_log/logger.dart';

class StarterApp extends StatelessWidget {
  final AppConfig config;

  const StarterApp({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    Get.put<AppConfig>(config, permanent: true);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: config.appName,
          debugShowCheckedModeBanner: false,
          initialBinding: DependencyInjection(),
          initialRoute: AppRoutes.splash,
          getPages: AppRoutes.instance.routes,
          unknownRoute: AppRoutes.instance.unknownRoute,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,
          routingCallback: (routing) {
            if (routing != null && routing.current.isNotEmpty) {
              if (routing.isDialog == true ||
                  routing.isBottomSheet == true) {
                return;
              }
              if (routing.isBack == true) {
                NavigationLogger.logPop(routing.current, routing.previous);
              } else {
                NavigationLogger.logPush(routing.current, routing.previous);
              }
            }
          },
        );
      },
    );
  }
}
