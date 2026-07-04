import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:getx_template/core/utils/helper/app_log.dart';

class FirebaseService {
  static Future<void> init() async {
    try {
      await Firebase.initializeApp();
    } catch (error, stackTrace) {
      if (kDebugMode) {
        AppLog.warning('Firebase not configured yet: $error');
        AppLog.error(
          'Firebase init skipped',
          error: error,
          stackTrace: stackTrace,
        );
      }
    }
  }
}
