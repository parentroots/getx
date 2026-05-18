import 'package:logger/logger.dart';
abstract final class LoggerHelper {
  static final Logger _logger = Logger(printer: PrettyPrinter(methodCount: 0));

  static void debug(String message) => _logger.d(message);
  static void info(String message) => _logger.i(message);
  static void warning(String message) => _logger.w(message);
  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
