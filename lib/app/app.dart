import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/app/app_config.dart';
import 'package:getx_template/bindings/initial_binding.dart';
import 'package:getx_template/localization/app_translations.dart';
import 'package:getx_template/routes/app_pages.dart';
import 'package:getx_template/routes/app_routes.dart';
import 'package:getx_template/theme/app_theme.dart';

class StarterApp extends StatelessWidget {
  const StarterApp({super.key, required this.config});

  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: config.appName,
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(config: config),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
      unknownRoute: AppPages.unknownRoute,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      translations: AppTranslations(),
      locale: AppTranslations.fallbackLocale,
      fallbackLocale: AppTranslations.fallbackLocale,
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 250),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: MediaQuery.textScalerOf(
              context,
            ).clamp(minScaleFactor: .9, maxScaleFactor: 1.25),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
