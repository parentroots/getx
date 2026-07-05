import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:getx_template/utils/app_log/app_log.dart';

class FirebaseService {
  static bool isInitialized = false;

  static Future<void> init() async {
    try {
      await Firebase.initializeApp();
      isInitialized = true;
    } catch (error) {
      isInitialized = false;
      if (kDebugMode) {
        AppLog.warning('Firebase not configured yet: $error (Firebase initialization skipped)');
      }
    }
  }
}
