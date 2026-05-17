import 'package:url_launcher/url_launcher.dart';

abstract final class UrlLauncherHelper {
  static Future<bool> open(
    String url, {
    LaunchMode mode = LaunchMode.platformDefault,
  }) {
    return launchUrl(Uri.parse(url), mode: mode);
  }

  static Future<bool> email(String email, {String? subject}) {
    return launchUrl(
      Uri(
        scheme: 'mailto',
        path: email,
        queryParameters: subject == null ? null : {'subject': subject},
      ),
    );
  }

  static Future<bool> phone(String phoneNumber) {
    return launchUrl(Uri(scheme: 'tel', path: phoneNumber));
  }
}
