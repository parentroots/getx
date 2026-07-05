import 'package:getx_template/utils/app_log/app_logger.dart';

/// A stopwatch utility designed for tracing and measuring transaction latency.
///
/// Under the hood, this integrates with Dart's native [Stopwatch] and routes
/// calculated durations into the [AppLogger] performance logging channel.
///
/// Example:
/// ```dart
/// final timer = PerformanceLogger.start();
/// // ... perform execution ...
/// timer.stop("Fetch Profile API");
/// ```
class PerformanceLogger {
  final Stopwatch _stopwatch;

  PerformanceLogger._(this._stopwatch);

  /// Starts a new stopwatch instance and returns a [PerformanceLogger] wrapper.
  factory PerformanceLogger.start() {
    final stopwatch = Stopwatch()..start();
    return PerformanceLogger._(stopwatch);
  }

  /// Stops the performance measurement and logs the duration under the specified [name].
  void stop(String name) {
    _stopwatch.stop();
    log.performance(name, _stopwatch.elapsed);
  }

  /// Measures a lap duration under the specified [lapName] without stopping the stopwatch.
  ///
  /// Useful for multi-stage performance audits.
  void lap(String lapName) {
    log.performance(lapName, _stopwatch.elapsed);
  }

  /// Restarts the stopwatch, clearing any recorded elapsed time.
  void restart() {
    _stopwatch.reset();
    _stopwatch.start();
  }

  /// Returns the raw elapsed [Duration] of this performance timer.
  Duration get elapsed => _stopwatch.elapsed;

  /// Returns whether the internal stopwatch is currently active.
  bool get isRunning => _stopwatch.isRunning;
}
