import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:getx_template/core/utils/logger_helper.dart';

class FirebaseService {
  static Future<void> init() async {
    try {
      await Firebase.initializeApp();
    } catch (error, stackTrace) {
      if (kDebugMode) {
        LoggerHelper.warning('Firebase not configured yet: $error');
        LoggerHelper.error(
          'Firebase init skipped',
          error: error,
          stackTrace: stackTrace,
        );
      }
    }
  }
}
