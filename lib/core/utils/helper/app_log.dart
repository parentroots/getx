import 'dart:convert';
import 'package:flutter/foundation.dart';

/// Enum representing the log level.
enum LogLevel {
  debug,
  info,
  success,
  warning,
  error,
  apiRequest,
  apiResponse,
  cache,
  database,
  navigation,
  auth,
  network,
  firebase,
  analytics,
  performance;

  /// Emoji representation of the log type.
  String get icon => switch (this) {
    LogLevel.debug => '⚙️',
    LogLevel.info => '📘',
    LogLevel.success => '✅',
    LogLevel.warning => '⚠️',
    LogLevel.error => '❌',
    LogLevel.apiRequest => '📤',
    LogLevel.apiResponse => '📥',
    LogLevel.cache => '💾',
    LogLevel.database => '🗄️',
    LogLevel.navigation => '🧭',
    LogLevel.auth => '🔐',
    LogLevel.network => '🌐',
    LogLevel.firebase => '🔥',
    LogLevel.analytics => '📈',
    LogLevel.performance => '⏱️',
  };

  /// String label.
  String get label => switch (this) {
    LogLevel.debug => 'DEBUG',
    LogLevel.info => 'INFO',
    LogLevel.success => 'SUCCESS',
    LogLevel.warning => 'WARNING',
    LogLevel.error => 'ERROR',
    LogLevel.apiRequest => 'API REQUEST',
    LogLevel.apiResponse => 'API RESPONSE',
    LogLevel.cache => 'CACHE',
    LogLevel.database => 'DATABASE',
    LogLevel.navigation => 'NAVIGATION',
    LogLevel.auth => 'AUTH',
    LogLevel.network => 'NETWORK',
    LogLevel.firebase => 'FIREBASE',
    LogLevel.analytics => 'ANALYTICS',
    LogLevel.performance => 'PERFORMANCE',
  };

  /// ANSI code sequences for colorful terminals.
  String get ansiColor => switch (this) {
    LogLevel.debug => '\x1B[90m',       // Gray
    LogLevel.info => '\x1B[34m',        // Blue
    LogLevel.success => '\x1B[32m',     // Green
    LogLevel.warning => '\x1B[33m',     // Yellow
    LogLevel.error => '\x1B[31m',       // Red
    LogLevel.apiRequest => '\x1B[35m',  // Purple
    LogLevel.apiResponse => '\x1B[36m', // Cyan
    LogLevel.cache => '\x1B[33m',       // Yellow
    LogLevel.database => '\x1B[32m',    // Green
    LogLevel.navigation => '\x1B[34m',  // Blue
    LogLevel.auth => '\x1B[31m',        // Red
    LogLevel.network => '\x1B[36m',     // Cyan
    LogLevel.firebase => '\x1B[31m',    // Red
    LogLevel.analytics => '\x1B[35m',   // Purple
    LogLevel.performance => '\x1B[36m', // Cyan
  };
}

/// Global appLog function.
void appLog(
  dynamic message, {
  String source = '',
  LogLevel level = LogLevel.info,
  Object? error,
  StackTrace? stackTrace,
}) {
  if (!kDebugMode) return;

  try {
    final timestamp = DateTime.now();
    final time =
        '${timestamp.hour.toString().padLeft(2, '0')}:'
        '${timestamp.minute.toString().padLeft(2, '0')}:'
        '${timestamp.second.toString().padLeft(2, '0')}.'
        '${timestamp.millisecond.toString().padLeft(3, '0')}';

    final icon = level.icon;
    final label = level.label;
    final color = level.ansiColor;
    const reset = '\x1B[0m';
    const divider = '═══════════════════════════════════════════════════════════════════';

    // Format message (pretty JSON if Map/List/JSON string)
    String formattedMessage;
    try {
      if (message is Map || message is List) {
        formattedMessage = const JsonEncoder.withIndent('  ').convert(message);
      } else {
        final decoded = jsonDecode(message.toString());
        formattedMessage = const JsonEncoder.withIndent('  ').convert(decoded);
      }
    } catch (_) {
      formattedMessage = message.toString();
    }

    final buffer = StringBuffer()
      ..writeln('$color  ╔$divider$reset')
      ..writeln('$color  ║$reset $icon  $label ${source.isNotEmpty ? '› $source' : ''}')
      ..writeln('$color  ║$reset 🕐 $time')
      ..writeln('$color  ╠$divider$reset');

    for (final line in formattedMessage.split('\n')) {
      buffer.writeln('$color  ║$reset  $line');
    }

    if (error != null) {
      buffer.writeln('$color  ╠$divider$reset');
      buffer.writeln('$color  ║$reset  🔴 Error: $error');
    }

    if (stackTrace != null) {
      buffer.writeln('$color  ╠$divider$reset');
      buffer.writeln('$color  ║$reset  📋 StackTrace:');
      final frames = stackTrace
          .toString()
          .split('\n')
          .where((l) => l.trim().isNotEmpty)
          .take(8);
      for (final frame in frames) {
        buffer.writeln('$color  ║$reset    $frame');
      }
    }

    buffer.write('$color  ╚$divider$reset');
    debugPrint(buffer.toString());
  } catch (e) {
    debugPrint('[appLog] Logging failed: $e');
  }
}

/// Static compatibility wrapper for AppLog.
abstract final class AppLog {
  static void debug(dynamic message, {String? details, String source = ''}) {
    appLog(details != null ? "$message\n$details" : message, source: source, level: LogLevel.debug);
  }

  static void info(dynamic message, {String? details, String source = ''}) {
    appLog(details != null ? "$message\n$details" : message, source: source, level: LogLevel.info);
  }

  static void success(dynamic message, {String? details, String source = ''}) {
    appLog(details != null ? "$message\n$details" : message, source: source, level: LogLevel.success);
  }

  static void warning(dynamic message, {String? details, String source = ''}) {
    appLog(details != null ? "$message\n$details" : message, source: source, level: LogLevel.warning);
  }

  static void error(
    dynamic message, {
    Object? error,
    StackTrace? stackTrace,
    String? details,
    String source = '',
  }) {
    appLog(
      details != null ? "$message\n$details" : message,
      source: source,
      level: LogLevel.error,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void apiRequest(dynamic message, {String? details, String source = ''}) {
    appLog(details != null ? "$message\n$details" : message, source: source, level: LogLevel.apiRequest);
  }

  static void apiResponse(dynamic message, {String? details, String source = ''}) {
    appLog(details != null ? "$message\n$details" : message, source: source, level: LogLevel.apiResponse);
  }

  static void api(dynamic message, {String? details, String source = ''}) {
    appLog(details != null ? "$message\n$details" : message, source: source, level: LogLevel.apiResponse);
  }

  static void network(dynamic message, {String? details, String source = ''}) {
    appLog(details != null ? "$message\n$details" : message, source: source, level: LogLevel.network);
  }

  static void cache(dynamic message, {String? details, String source = ''}) {
    appLog(details != null ? "$message\n$details" : message, source: source, level: LogLevel.cache);
  }

  static void database(dynamic message, {String? details, String source = ''}) {
    appLog(details != null ? "$message\n$details" : message, source: source, level: LogLevel.database);
  }

  static void navigation(dynamic message, {String? details, String source = ''}) {
    appLog(details != null ? "$message\n$details" : message, source: source, level: LogLevel.navigation);
  }

  static void auth(dynamic message, {String? details, String source = ''}) {
    appLog(details != null ? "$message\n$details" : message, source: source, level: LogLevel.auth);
  }

  static void firebase(dynamic message, {String? details, String source = ''}) {
    appLog(details != null ? "$message\n$details" : message, source: source, level: LogLevel.firebase);
  }

  static void analytics(dynamic message, {String? details, String source = ''}) {
    appLog(details != null ? "$message\n$details" : message, source: source, level: LogLevel.analytics);
  }

  static void performance(dynamic message, {String? details, String source = ''}) {
    appLog(details != null ? "$message\n$details" : message, source: source, level: LogLevel.performance);
  }
}
