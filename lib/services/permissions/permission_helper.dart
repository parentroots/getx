import 'package:permission_handler/permission_handler.dart';

abstract final class PermissionHelper {
  static Future<bool> request(Permission permission) async {
    final status = await permission.request();
    return status.isGranted || status.isLimited;
  }

  static Future<bool> camera() => request(Permission.camera);
  static Future<bool> photos() => request(Permission.photos);
  static Future<bool> notification() => request(Permission.notification);
}
