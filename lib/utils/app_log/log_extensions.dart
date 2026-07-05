import 'package:getx_template/utils/app_log/app_logger.dart';

/// Static extension methods on [Object] to streamline logging invocations.
///
/// Allows developers to log any object state or message inline (e.g. `user.logDebug()`).
extension LoggerObjectExtension on Object? {
  /// Logs the object as a debug diagnostic message.
  void logDebug() => log.d(this);

  /// Logs the object as an informational message.
  void logInfo() => log.i(this);

  /// Logs the object as a confirmed success operation.
  void logSuccess() => log.success(this);

  /// Logs the object as a warning.
  void logWarning() => log.w(this);

  /// Logs the object as an error message with optional error and stack trace.
  void logError([Object? error, StackTrace? stackTrace]) => log.e(this, error, stackTrace);

  /// Logs the object as a Firebase event with optional detail data.
  void logFirebase([dynamic detail]) => log.firebase(this, detail);

  /// Logs the object as an Authentication status or process.
  void logAuth([dynamic detail]) => log.auth(this, detail);

  /// Logs the object as a network message.
  void logNetwork() => log.network(this);

  /// Logs the object as a local cache trace.
  void logCache() => log.cache(this);

  /// Logs the object as a database transaction message.
  void logDatabase() => log.database(this);

  /// Logs the object as a navigation event.
  void logNavigation() => log.navigation(this);

  /// Logs the object as an analytics event.
  void logAnalytics() => log.analytics(this);
}
