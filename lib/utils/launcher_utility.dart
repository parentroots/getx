import 'package:getx_template/services/launcher/url_launcher_helper.dart';

abstract final class LauncherUtility {
  static Future<bool> openWebsite(String url) => UrlLauncherHelper.open(url);
  static Future<bool> callSupport(String phone) =>
      UrlLauncherHelper.phone(phone);
  static Future<bool> emailSupport(String email) =>
      UrlLauncherHelper.email(email);
}
