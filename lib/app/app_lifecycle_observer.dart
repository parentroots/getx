import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_template/core/utils/logger_helper.dart';

class AppLifecycleObserver extends GetxService with WidgetsBindingObserver {
  Future<AppLifecycleObserver> init() async {
    WidgetsBinding.instance.addObserver(this);
    return this;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    LoggerHelper.debug('App lifecycle changed: $state');
    super.didChangeAppLifecycleState(state);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }
}
