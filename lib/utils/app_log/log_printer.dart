import 'package:flutter/foundation.dart';
import 'package:getx_template/utils/app_log/log_level.dart';

/// The contract for outputs of the logging system.
///
/// Implement this to stream formatted log outputs to the console, files,
/// crash reporting servers (like Crashlytics), or remote logging endpoints.
abstract interface class LogPrinter {
  /// Outputs the pre-formatted lines to the target output stream.
  void printLines(LogLevel level, List<String> lines);
}

/// The default printer that outputs logs line-by-line to the console.
///
/// Uses Flutter's [debugPrint] to avoid terminal line truncation issues
/// commonly experienced in some systems with standard [print].
class ConsoleLogPrinter implements LogPrinter {
  const ConsoleLogPrinter();

  @override
  void printLines(LogLevel level, List<String> lines) {
    for (final line in lines) {
      debugPrint(line);
    }
  }
}
