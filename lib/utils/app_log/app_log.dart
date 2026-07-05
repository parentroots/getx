import 'package:getx_template/utils/app_log/logger.dart' as new_logger;

/// Legacy LogLevel enum kept for backward compatibility with existing files.
typedef LogLevel = new_logger.LogLevel;

/// Legacy appLog function delegating to the new enterprise logger.
void appLog(
  dynamic message, {
  String source = '',
  LogLevel level = LogLevel.info,
  Object? error,
  StackTrace? stackTrace,
}) {
  final finalMessage = source.isNotEmpty ? '[$source] $message' : message;

  switch (level) {
    case LogLevel.debug:
      new_logger.log.d(finalMessage);
    case LogLevel.info:
      new_logger.log.i(finalMessage);
    case LogLevel.success:
      new_logger.log.success(finalMessage);
    case LogLevel.warning:
      new_logger.log.w(finalMessage);
    case LogLevel.error:
      new_logger.log.e(finalMessage, error, stackTrace);
    case LogLevel.apiRequest:
      if (message is Map<String, dynamic>) {
        new_logger.log.apiRequest(
          method: message['method'] as String? ?? 'GET',
          url: message['url'] as String? ?? '',
          headers: message['headers'] is Map<String, dynamic>
              ? message['headers'] as Map<String, dynamic>
              : null,
          body: message['body'],
        );
      } else {
        new_logger.log.d('API Request: $message');
      }
    case LogLevel.apiResponse:
      if (message is Map<String, dynamic>) {
        new_logger.log.apiResponse(
          statusCode: message['statusCode'] as int? ?? 200,
          duration: message['duration'] is Duration ? message['duration'] as Duration : Duration.zero,
          body: message['body'],
        );
      } else {
        new_logger.log.d('API Response: $message');
      }
    case LogLevel.cache:
      new_logger.log.cache(finalMessage);
    case LogLevel.database:
      new_logger.log.database(finalMessage);
    case LogLevel.navigation:
      new_logger.log.navigation(finalMessage);
    case LogLevel.auth:
      new_logger.log.auth(finalMessage);
    case LogLevel.network:
      new_logger.log.network(finalMessage);
    case LogLevel.firebase:
      new_logger.log.firebase(finalMessage);
    case LogLevel.analytics:
      new_logger.log.analytics(finalMessage);
    case LogLevel.performance:
      if (message is Map<String, dynamic>) {
        new_logger.log.performance(
          message['name'] as String? ?? 'Action',
          message['duration'] is Duration ? message['duration'] as Duration : Duration.zero,
        );
      } else {
        new_logger.log.performance(finalMessage.toString(), Duration.zero);
      }
  }
}

/// Legacy AppLog class kept for compatibility, delegating calls to the new logger.
abstract final class AppLog {
  static void debug(dynamic message, {String? details, String source = ''}) {
    _log(LogLevel.debug, message, details: details, source: source);
  }

  static void info(dynamic message, {String? details, String source = ''}) {
    _log(LogLevel.info, message, details: details, source: source);
  }

  static void success(dynamic message, {String? details, String source = ''}) {
    _log(LogLevel.success, message, details: details, source: source);
  }

  static void warning(dynamic message, {String? details, String source = ''}) {
    _log(LogLevel.warning, message, details: details, source: source);
  }

  static void error(
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
    String? details,
    String source = '',
  }) {
    final finalMessage = details != null ? '$message\n$details' : message;
    appLog(finalMessage, source: source, level: LogLevel.error, error: error, stackTrace: stackTrace);
  }

  static void apiRequest(dynamic message, {String? details, String source = ''}) {
    _log(LogLevel.apiRequest, message, details: details, source: source);
  }

  static void apiResponse(dynamic message, {String? details, String source = ''}) {
    _log(LogLevel.apiResponse, message, details: details, source: source);
  }

  static void api(dynamic message, {String? details, String source = ''}) {
    _log(LogLevel.apiResponse, message, details: details, source: source);
  }

  static void network(dynamic message, {String? details, String source = ''}) {
    _log(LogLevel.network, message, details: details, source: source);
  }

  static void cache(dynamic message, {String? details, String source = ''}) {
    _log(LogLevel.cache, message, details: details, source: source);
  }

  static void database(dynamic message, {String? details, String source = ''}) {
    _log(LogLevel.database, message, details: details, source: source);
  }

  static void navigation(dynamic message, {String? details, String source = ''}) {
    _log(LogLevel.navigation, message, details: details, source: source);
  }

  static void auth(dynamic message, {String? details, String source = ''}) {
    _log(LogLevel.auth, message, details: details, source: source);
  }

  static void firebase(dynamic message, {String? details, String source = ''}) {
    _log(LogLevel.firebase, message, details: details, source: source);
  }

  static void analytics(dynamic message, {String? details, String source = ''}) {
    _log(LogLevel.analytics, message, details: details, source: source);
  }

  static void performance(dynamic message, {String? details, String source = ''}) {
    _log(LogLevel.performance, message, details: details, source: source);
  }

  static void _log(LogLevel level, dynamic message, {String? details, String source = ''}) {
    final finalMessage = details != null ? '$message\n$details' : message;
    appLog(finalMessage, source: source, level: level);
  }
}
