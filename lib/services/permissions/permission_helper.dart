import 'package:permission_handler/permission_handler.dart';

/// A premium, self-documenting utility service designed to manage, check,
/// and request system-level permissions dynamically inside the application.
abstract final class PermissionHelper {
  
  /// General handler to request any [Permission].
  /// Returns `true` if the permission was granted or limited, and `false` otherwise.
  static Future<bool> request(Permission permission) async {
    final status = await permission.request();
    return status.isGranted || status.isLimited;
  }

  /// Request access to the system Camera.
  static Future<bool> camera() => request(Permission.camera);

  /// Request access to the system photo library / gallery.
  static Future<bool> photos() => request(Permission.photos);

  /// Request permission to show Push and Local Notifications.
  static Future<bool> notification() => request(Permission.notification);
}
