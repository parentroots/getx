import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:getx_template/core/utils/logger_helper.dart';

class NotificationService extends GetxService {
  Future<NotificationService> init() async {
    try {
      final messaging = FirebaseMessaging.instance;
      await messaging.requestPermission();
      final token = await messaging.getToken();
      LoggerHelper.debug('FCM token: $token');
    } catch (error, stackTrace) {
      LoggerHelper.warning('Notifications not configured yet: $error');
      LoggerHelper.error(
        'Notification init skipped',
        error: error,
        stackTrace: stackTrace,
      );
    }
    return this;
  }
}
