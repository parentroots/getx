import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/localization/locale_keys.dart';

class AppTranslations extends Translations {
  static const fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      LocaleKeys.appName: 'GetX Starter',
      LocaleKeys.retry: 'Retry',
      LocaleKeys.cancel: 'Cancel',
      LocaleKeys.confirm: 'Confirm',
      LocaleKeys.loading: 'Loading',
      LocaleKeys.noInternet: 'No internet connection',
    },
  };
}
