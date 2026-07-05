import 'package:getx_template/utils/app_log/log_level.dart';
import 'package:getx_template/utils/app_log/log_utils.dart';

/// The contract for formatting raw log components into structured console lines.
abstract interface class LogFormatter {
  /// Formats log information into a list of strings representing console lines.
  List<String> format({
    required LogLevel level,
    required dynamic message,
    required LogCallerInfo callerInfo,
    required DateTime timestamp,
    Object? error,
    StackTrace? stackTrace,
  });
}

/// A highly polished, terminal-friendly implementation of [LogFormatter].
///
/// Constructs box-drawn structures tailored for standard logs, API requests,
/// API responses, and errors, complete with ANSI coloring and emojis.
class BeautifulLogFormatter implements LogFormatter {
  /// Defines the width of the box borders in characters.
  final int borderWidth;

  /// Whether to include ANSI colors in the output.
  final bool useColors;

  /// Whether to include Emojis in the labels.
  final bool useEmojis;

  const BeautifulLogFormatter({
    this.borderWidth = 50,
    this.useColors = true,
    this.useEmojis = true,
  });

  // Border characters
  static const String _topLeft = '╔';
  static const String _horizontal = '═';
  static const String _middleLeft = '╠';
  static const String _bottomLeft = '╚';
  static const String _vertical = '║';

  String get _line => _horizontal * borderWidth;

  @override
  List<String> format({
    required LogLevel level,
    required dynamic message,
    required LogCallerInfo callerInfo,
    required DateTime timestamp,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final color = useColors ? level.ansiColor : '';
    final reset = useColors ? LogLevel.ansiReset : '';

    final headerIcon = useEmojis ? '${level.emoji} ' : '';
    final headerLabel = '$headerIcon${level.label}';

    final lines = <String>[];

    // 1. FORMAT BY LOG LEVEL CATEGORY
    if (level == LogLevel.apiRequest) {
      lines.addAll(_formatApiRequest(message, headerLabel, timestamp, color, reset));
    } else if (level == LogLevel.apiResponse) {
      lines.addAll(_formatApiResponse(message, headerLabel, color, reset));
    } else if (level == LogLevel.performance) {
      lines.addAll(_formatPerformance(message, color, reset));
    } else if (level == LogLevel.error) {
      lines.addAll(_formatError(message, headerLabel, callerInfo, timestamp, error, stackTrace, color, reset));
    } else {
      // Standard log level (debug, info, success, warning, firebase, auth, network, database, cache, navigation, analytics)
      lines.addAll(_formatStandard(level, message, headerLabel, callerInfo, timestamp, error, stackTrace, color, reset));
    }

    return lines;
  }

  /// Formats standard messages with metadata (Time, File, Line) and pretty-prints JSON payload if detected.
  List<String> _formatStandard(
    LogLevel level,
    dynamic message,
    String headerLabel,
    LogCallerInfo caller,
    DateTime timestamp,
    Object? error,
    StackTrace? stackTrace,
    String color,
    String reset,
  ) {
    final lines = <String>[];
    final timeStr = _formatTimestamp(timestamp);

    // Top Border & Header
    lines.add('$color$_topLeft$_line$reset');
    lines.add('$color$_vertical$reset $headerLabel');
    lines.add('$color$_vertical$reset Time : $timeStr');
    lines.add('$color$_vertical$reset File : ${caller.fileName}');
    lines.add('$color$_vertical$reset Line : ${caller.lineNumber}');
    lines.add('$color$_middleLeft$_line$reset');

    // Message Body (with pretty JSON detection)
    final formattedMessage = LogUtils.formatJson(message);
    for (final line in formattedMessage.split('\n')) {
      lines.add('$color$_vertical$reset $line');
    }

    // Optional Error and Stack Trace for warning/info logs
    if (error != null) {
      lines.add('$color$_vertical$reset');
      lines.add('$color$_vertical$reset Error: $error');
    }
    if (stackTrace != null) {
      lines.add('$color$_vertical$reset');
      lines.add('$color$_vertical$reset Stack Trace:');
      for (final frame in stackTrace.toString().split('\n').take(8)) {
        if (frame.trim().isNotEmpty) {
          lines.add('$color$_vertical$reset   $frame');
        }
      }
    }

    // Bottom Border
    lines.add('$color$_bottomLeft$_line$reset');
    return lines;
  }

  /// Formats error logs, placing the error string and full stack trace in clean blocks.
  List<String> _formatError(
    dynamic message,
    String headerLabel,
    LogCallerInfo caller,
    DateTime timestamp,
    Object? error,
    StackTrace? stackTrace,
    String color,
    String reset,
  ) {
    final lines = <String>[];
    final timeStr = _formatTimestamp(timestamp);

    // Top Border & Header
    lines.add('$color$_topLeft$_line$reset');
    lines.add('$color$_vertical$reset $headerLabel');
    lines.add('$color$_vertical$reset Time : $timeStr');
    lines.add('$color$_vertical$reset File : ${caller.fileName}');
    lines.add('$color$_vertical$reset Line : ${caller.lineNumber}');
    lines.add('$color$_middleLeft$_line$reset');

    // Primary Error Message
    lines.add('$color$_vertical$reset $message');

    // Actual Exception Object
    if (error != null) {
      lines.add('$color$_vertical$reset');
      lines.add('$color$_vertical$reset Error');
      final formattedError = LogUtils.formatJson(error);
      for (final line in formattedError.split('\n')) {
        lines.add('$color$_vertical$reset $line');
      }
    }

    // Stack Trace
    if (stackTrace != null) {
      lines.add('$color$_vertical$reset');
      lines.add('$color$_vertical$reset Stack Trace');
      for (final frame in stackTrace.toString().split('\n')) {
        if (frame.trim().isNotEmpty) {
          lines.add('$color$_vertical$reset $frame');
        }
      }
    }

    // Bottom Border
    lines.add('$color$_bottomLeft$_line$reset');
    return lines;
  }

  /// Formats API request logs containing HTTP Method, URL, Headers, and Request Body.
  List<String> _formatApiRequest(
    dynamic message,
    String headerLabel,
    DateTime timestamp,
    String color,
    String reset,
  ) {
    final lines = <String>[];
    final timeStr = _formatTimestamp(timestamp);

    lines.add('$color$_topLeft$_line$reset');
    lines.add('$color$_vertical$reset $headerLabel');
    lines.add('$color$_vertical$reset Time : $timeStr');
    lines.add('$color$_middleLeft$_line$reset');

    if (message is Map<String, dynamic>) {
      final method = message['method'] ?? 'UNKNOWN';
      final url = message['url'] ?? '';
      final headers = message['headers'];
      final body = message['body'];

      lines.add('$color$_vertical$reset $method');
      lines.add('$color$_vertical$reset $url');

      if (headers != null && headers.toString().isNotEmpty && headers.toString() != '{}') {
        lines.add('$color$_vertical$reset');
        lines.add('$color$_vertical$reset Headers');
        final formattedHeaders = LogUtils.formatJson(headers);
        for (final line in formattedHeaders.split('\n')) {
          lines.add('$color$_vertical$reset   $line');
        }
      }

      if (body != null && body.toString().isNotEmpty && body.toString() != '{}') {
        lines.add('$color$_vertical$reset');
        lines.add('$color$_vertical$reset Body');
        final formattedBody = LogUtils.formatJson(body);
        for (final line in formattedBody.split('\n')) {
          lines.add('$color$_vertical$reset   $line');
        }
      }
    } else {
      // Fallback if message is string
      lines.add('$color$_vertical$reset $message');
    }

    lines.add('$color$_bottomLeft$_line$reset');
    return lines;
  }

  /// Formats API response logs containing HTTP Status Code, Duration (ms), and Response Body.
  List<String> _formatApiResponse(
    dynamic message,
    String headerLabel,
    String color,
    String reset,
  ) {
    final lines = <String>[];

    lines.add('$color$_topLeft$_line$reset');
    lines.add('$color$_vertical$reset $headerLabel');
    lines.add('$color$_middleLeft$_line$reset');

    if (message is Map<String, dynamic>) {
      final status = message['statusCode'];
      final duration = message['duration'];
      final body = message['body'];

      if (status != null) {
        lines.add('$color$_vertical$reset Status : $status');
      }
      if (duration != null) {
        if (duration is Duration) {
          lines.add('$color$_vertical$reset Time : ${duration.inMilliseconds} ms');
        } else {
          lines.add('$color$_vertical$reset Time : $duration');
        }
      }

      if (body != null && body.toString().isNotEmpty && body.toString() != '{}') {
        lines.add('$color$_vertical$reset');
        lines.add('$color$_vertical$reset Response');
        final formattedBody = LogUtils.formatJson(body);
        for (final line in formattedBody.split('\n')) {
          lines.add('$color$_vertical$reset   $line');
        }
      }
    } else {
      lines.add('$color$_vertical$reset $message');
    }

    lines.add('$color$_bottomLeft$_line$reset');
    return lines;
  }

  /// Formats stopwatch performance outputs.
  List<String> _formatPerformance(
    dynamic message,
    String color,
    String reset,
  ) {
    final lines = <String>[];

    if (message is Map<String, dynamic>) {
      final name = message['name'] ?? 'Action';
      final duration = message['duration'];
      final formattedDuration = duration is Duration ? '${duration.inMilliseconds} ms' : duration.toString();

      lines.add('$color⏱ $name$reset');
      lines.add('${color}Finished in $formattedDuration$reset');
    } else {
      lines.add('$color⏱ $message$reset');
    }

    return lines;
  }

  /// Formats a [DateTime] into a standard `HH:mm:ss.SSS` format.
  String _formatTimestamp(DateTime time) {
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    final s = time.second.toString().padLeft(2, '0');
    final ms = time.millisecond.toString().padLeft(3, '0');
    return '$h:$m:$s.$ms';
  }
}
