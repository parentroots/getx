import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:getx_template/core/utils/helper/app_log.dart';

class NotificationService extends GetxService {
  Future<NotificationService> init() async {
    try {
      final messaging = FirebaseMessaging.instance;
      await messaging.requestPermission();
      final token = await messaging.getToken();
      AppLog.debug('FCM token: $token');
    } catch (error, stackTrace) {
      AppLog.warning(
          'Notifications not configured yet: $error');
      AppLog.error(
        'Notification init skipped',
        error: error,
        stackTrace: stackTrace,
      );
    }
    return this;
  }
}
