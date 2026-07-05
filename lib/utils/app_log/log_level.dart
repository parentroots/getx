/// Represents the urgency and category of a log entry.
///
/// Log levels define both the severity and the domain (e.g., database, cache)
/// of the event being logged.
enum LogLevel {
  /// Diagnostic logs for developers.
  debug,

  /// Informational messages.
  info,

  /// Indication of successful operations.
  success,

  /// Non-blocking concerns or warnings.
  warning,

  /// Errors and exceptions.
  error,

  /// Firebase integration events.
  firebase,

  /// Authentication events (login, logout, token refreshes).
  auth,

  /// Outgoing API requests.
  apiRequest,

  /// Incoming API responses.
  apiResponse,

  /// General network status or check logs.
  network,

  /// Cache hits, misses, and writes.
  cache,

  /// SQL/NoSQL database queries and results.
  database,

  /// App navigation and routing events.
  navigation,

  /// Marketing and tracking analytics events.
  analytics,

  /// Performance tracing, benchmarking, and duration logs.
  performance;

  /// Returns the emoji icon associated with the log level.
  String get emoji => switch (this) {
        LogLevel.debug => '⚙️',
        LogLevel.info => '📘',
        LogLevel.success => '✅',
        LogLevel.warning => '⚠️',
        LogLevel.error => '❌',
        LogLevel.firebase => '🔥',
        LogLevel.auth => '🔑',
        LogLevel.apiRequest => '📤',
        LogLevel.apiResponse => '📥',
        LogLevel.network => '🌐',
        LogLevel.cache => '💾',
        LogLevel.database => '🗄️',
        LogLevel.navigation => '🧭',
        LogLevel.analytics => '📊',
        LogLevel.performance => '⏱️',
      };

  /// Returns the uppercase text label for the log level.
  String get label => switch (this) {
        LogLevel.debug => 'DEBUG',
        LogLevel.info => 'INFO',
        LogLevel.success => 'SUCCESS',
        LogLevel.warning => 'WARNING',
        LogLevel.error => 'ERROR',
        LogLevel.firebase => 'FIREBASE',
        LogLevel.auth => 'AUTHENTICATION',
        LogLevel.apiRequest => 'API REQUEST',
        LogLevel.apiResponse => 'API RESPONSE',
        LogLevel.network => 'NETWORK',
        LogLevel.cache => 'CACHE',
        LogLevel.database => 'DATABASE',
        LogLevel.navigation => 'NAVIGATION',
        LogLevel.analytics => 'ANALYTICS',
        LogLevel.performance => 'PERFORMANCE',
      };

  /// Returns the ANSI escape color sequence for colorful console terminal output.
  String get ansiColor => switch (this) {
        LogLevel.debug => '\x1B[90m',       // Gray
        LogLevel.info => '\x1B[34m',        // Blue
        LogLevel.success => '\x1B[32m',     // Green
        LogLevel.warning => '\x1B[33m',     // Yellow
        LogLevel.error => '\x1B[31m',       // Red
        LogLevel.firebase => '\x1B[31m',    // Red (Matches Firebase orange/red theme)
        LogLevel.auth => '\x1B[36m',        // Cyan
        LogLevel.apiRequest => '\x1B[35m',  // Magenta/Purple
        LogLevel.apiResponse => '\x1B[36m', // Cyan
        LogLevel.network => '\x1B[36m',     // Cyan
        LogLevel.cache => '\x1B[33m',       // Yellow
        LogLevel.database => '\x1B[32m',    // Green
        LogLevel.navigation => '\x1B[34m',  // Blue
        LogLevel.analytics => '\x1B[35m',   // Purple
        LogLevel.performance => '\x1B[94m', // Light Blue
      };

  /// Reset sequence to return the console color to default.
  static const String ansiReset = '\x1B[0m';
}
