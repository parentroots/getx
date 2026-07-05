import 'package:getx_template/utils/app_log/log_formatter.dart';
import 'package:getx_template/utils/app_log/log_level.dart';
import 'package:getx_template/utils/app_log/log_printer.dart';
import 'package:getx_template/utils/app_log/log_utils.dart';

/// Configuration rules for the logging system.
///
/// Permits toggling on/off individual clusters of log levels depending on the environment.
class LoggerConfig {
  /// Toggle for [LogLevel.debug], [LogLevel.info], and [LogLevel.success].
  final bool enableDebug;

  /// Toggle for [LogLevel.apiRequest], [LogLevel.apiResponse], and [LogLevel.network].
  final bool enableApi;

  /// Toggle for [LogLevel.firebase].
  final bool enableFirebase;

  /// Toggle for [LogLevel.auth].
  final bool enableAuth;

  /// Toggle for [LogLevel.performance].
  final bool enablePerformance;

  /// Toggle for [LogLevel.navigation].
  final bool enableNavigation;

  /// Toggle for [LogLevel.analytics].
  final bool enableAnalytics;

  /// Toggle for [LogLevel.error] and [LogLevel.warning].
  final bool enableErrors;

  /// Toggle for [LogLevel.database].
  final bool enableDatabase;

  /// Toggle for [LogLevel.cache].
  final bool enableCache;

  const LoggerConfig({
    this.enableDebug = true,
    this.enableApi = true,
    this.enableFirebase = true,
    this.enableAuth = true,
    this.enablePerformance = true,
    this.enableNavigation = true,
    this.enableAnalytics = true,
    this.enableErrors = true,
    this.enableDatabase = true,
    this.enableCache = true,
  });

  /// Factory constructor to disable all logging (useful in production releases).
  factory LoggerConfig.silent() => const LoggerConfig(
        enableDebug: false,
        enableApi: false,
        enableFirebase: false,
        enableAuth: false,
        enablePerformance: false,
        enableNavigation: false,
        enableAnalytics: false,
        enableErrors: false,
        enableDatabase: false,
        enableCache: false,
      );

  /// Factory constructor to enable only error-related logs.
  factory LoggerConfig.errorsOnly() => const LoggerConfig(
        enableDebug: false,
        enableApi: false,
        enableFirebase: false,
        enableAuth: false,
        enablePerformance: false,
        enableNavigation: false,
        enableAnalytics: false,
        enableErrors: true,
        enableDatabase: false,
        enableCache: false,
      );
}

/// The core Logging class implementing the Clean Architecture logging interface.
class AppLogger {
  LoggerConfig _config;
  LogFormatter _formatter;
  LogPrinter _printer;

  /// Private internal constructor for Singleton implementation.
  AppLogger._internal({
    LoggerConfig? config,
    LogFormatter? formatter,
    LogPrinter? printer,
  })  : _config = config ?? const LoggerConfig(),
        _formatter = formatter ?? const BeautifulLogFormatter(),
        _printer = printer ?? const ConsoleLogPrinter();

  /// The static singleton instance of the logger.
  static final AppLogger instance = AppLogger._internal();

  /// Configures or overrides the configuration, formatter, and printer of the logger.
  void configure({
    LoggerConfig? config,
    LogFormatter? formatter,
    LogPrinter? printer,
  }) {
    if (config != null) _config = config;
    if (formatter != null) _formatter = formatter;
    if (printer != null) _printer = printer;
  }

  /// Checks if a given log level is enabled under the current configuration.
  bool _isLevelEnabled(LogLevel level) {
    return switch (level) {
      LogLevel.debug || LogLevel.info || LogLevel.success => _config.enableDebug,
      LogLevel.warning || LogLevel.error => _config.enableErrors,
      LogLevel.firebase => _config.enableFirebase,
      LogLevel.auth => _config.enableAuth,
      LogLevel.apiRequest || LogLevel.apiResponse || LogLevel.network => _config.enableApi,
      LogLevel.cache => _config.enableCache,
      LogLevel.database => _config.enableDatabase,
      LogLevel.navigation => _config.enableNavigation,
      LogLevel.analytics => _config.enableAnalytics,
      LogLevel.performance => _config.enablePerformance,
    };
  }

  /// Base dispatch logging method that resolves formatting and printing.
  void _log(
    LogLevel level,
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!_isLevelEnabled(level)) return;

    // Automatically detect caller traceback (skips frames internal to this logger package)
    final callerInfo = LogUtils.getCallerInfo();

    final lines = _formatter.format(
      level: level,
      message: message,
      callerInfo: callerInfo,
      timestamp: DateTime.now(),
      error: error,
      stackTrace: stackTrace,
    );

    _printer.printLines(level, lines);
  }

  // ==========================================
  // PUBLIC LOGGING API METHODS
  // ==========================================

  /// Logs a debug diagnostic message.
  void d(dynamic message) => _log(LogLevel.debug, message);

  /// Logs an informational message.
  void i(dynamic message) => _log(LogLevel.info, message);

  /// Logs an operation success confirmation.
  void success(dynamic message) => _log(LogLevel.success, message);

  /// Logs a warning, indicating minor anomalies that don't block execution.
  void w(dynamic message) => _log(LogLevel.warning, message);

  /// Logs a critical failure, exception, or program error with optional stack trace.
  void e(dynamic message, [Object? error, StackTrace? stackTrace]) {
    _log(
      LogLevel.error,
      message,
      error: error,
      stackTrace: stackTrace ?? StackTrace.current,
    );
  }

  /// Logs Firebase-specific events (e.g. notifications, FCM tokens).
  void firebase(dynamic message, [dynamic detail]) {
    if (detail != null) {
      _log(LogLevel.firebase, {
        'message': message,
        'detail': detail,
      });
    } else {
      _log(LogLevel.firebase, message);
    }
  }

  /// Logs Authentication status, processes, or token cycles.
  void auth(dynamic message, [dynamic detail]) {
    if (detail != null) {
      _log(LogLevel.auth, {
        'message': message,
        'detail': detail,
      });
    } else {
      _log(LogLevel.auth, message);
    }
  }

  /// Logs outgoing API network request bodies, headers, method, and URL.
  void apiRequest({
    required String method,
    required String url,
    Map<String, dynamic>? headers,
    dynamic body,
  }) {
    _log(LogLevel.apiRequest, {
      'method': method,
      'url': url,
      'headers': headers,
      'body': body,
    });
  }

  /// Logs incoming API response bodies, status code, and latency duration.
  void apiResponse({
    required int statusCode,
    required Duration duration,
    dynamic body,
  }) {
    _log(LogLevel.apiResponse, {
      'statusCode': statusCode,
      'duration': duration,
      'body': body,
    });
  }

  /// Logs low-level socket connections or general networking info.
  void network(dynamic message) => _log(LogLevel.network, message);

  /// Logs local cache changes, writes, queries, or expirations.
  void cache(dynamic message) => _log(LogLevel.cache, message);

  /// Logs local database queries, reads, updates, and transaction results.
  void database(dynamic message) => _log(LogLevel.database, message);

  /// Logs navigation transitions, screen entries, tab switches, and route pops.
  void navigation(dynamic message) => _log(LogLevel.navigation, message);

  /// Logs analytics reporting, event trackers, and telemetry data.
  void analytics(dynamic message) => _log(LogLevel.analytics, message);

  /// Logs operation execution durations for benchmarks.
  void performance(String name, Duration duration) {
    _log(LogLevel.performance, {
      'name': name,
      'duration': duration,
    });
  }
}

/// Global convenience handle for accessing the logging API without verbose imports.
final log = AppLogger.instance;
