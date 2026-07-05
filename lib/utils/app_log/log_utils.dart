import 'dart:convert';

/// Data class representing caller trace information.
class LogCallerInfo {
  /// The name of the file where the log was called (e.g., `home_page.dart`).
  final String fileName;

  /// The name of the class (if any) where the log was called.
  final String className;

  /// The name of the method/function where the log was called.
  final String methodName;

  /// The line number in the source file.
  final int lineNumber;

  const LogCallerInfo({
    required this.fileName,
    required this.className,
    required this.methodName,
    required this.lineNumber,
  });

  @override
  String toString() {
    final classPrefix = className.isNotEmpty ? '$className.' : '';
    return '$classPrefix$methodName ($fileName:$lineNumber)';
  }
}

/// A suite of utilities for parsing stack traces and formatting JSON structures.
abstract final class LogUtils {
  /// Pretty prints JSON data (Maps, Lists, or JSON Strings) with indentation.
  ///
  /// If the input is not a valid JSON structure or string representation of JSON,
  /// it returns the input's string value as is.
  static String formatJson(dynamic input) {
    if (input == null) return 'null';

    try {
      if (input is Map || input is List) {
        return const JsonEncoder.withIndent('  ').convert(input);
      }

      if (input is String) {
        final trimmed = input.trim();
        if ((trimmed.startsWith('{') && trimmed.endsWith('}')) ||
            (trimmed.startsWith('[') && trimmed.endsWith(']'))) {
          final decoded = json.decode(trimmed);
          return const JsonEncoder.withIndent('  ').convert(decoded);
        }
      }
    } catch (_) {
      // Fallback to default string representation if parsing/formatting fails.
    }

    return input.toString();
  }

  /// Automatically parses the stack trace to detect the caller's file, class,
  /// method, and line number.
  ///
  /// If [stackTrace] is null, it captures [StackTrace.current]. It filters out
  /// internal logger frames to find the user's invocation frame.
  static LogCallerInfo getCallerInfo([StackTrace? stackTrace]) {
    final trace = stackTrace ?? StackTrace.current;
    final lines = trace.toString().split('\n');

    for (final line in lines) {
      if (line.isEmpty) continue;

      // Skip frames from inside this logger directory to locate the actual caller
      if (line.contains('utils/app_log/') ||
          line.contains('logger.dart') ||
          line.contains('app_logger.dart') ||
          line.contains('log_utils.dart') ||
          line.contains('log_formatter.dart') ||
          line.contains('log_printer.dart')) {
        continue;
      }

      // Also skip asynchronous/internal zones if they happen to appear first
      if (line.contains('dart:async') ||
          line.contains('dart:isolate-patch') ||
          line.contains('package:stack_trace')) {
        continue;
      }

      final info = _parseTraceLine(line);
      if (info != null) {
        return info;
      }
    }

    return const LogCallerInfo(
      fileName: 'unknown_file.dart',
      className: '',
      methodName: 'unknownMethod',
      lineNumber: 0,
    );
  }

  /// Parses a single stack trace line.
  ///
  /// Supports both standard VM traces:
  /// `#1      MyClass.myMethod (package:my_project/src/my_file.dart:12:34)`
  /// and Web/Browser traces:
  /// `package:my_project/src/my_file.dart 12:34 MyClass.myMethod`
  static LogCallerInfo? _parseTraceLine(String line) {
    try {
      // VM Stack Frame parsing
      if (line.contains('(') && line.contains(')')) {
        final openParen = line.lastIndexOf('(');
        final closeParen = line.lastIndexOf(')');
        if (openParen == -1 || closeParen == -1 || openParen >= closeParen) {
          return null;
        }

        final location = line.substring(openParen + 1, closeParen).trim();
        // Location format: "package:my_project/path/file.dart:12:34" or "file:///path/file.dart:12:34"
        final locationParts = location.split(':');
        if (locationParts.length < 2) return null;

        // Extract line number (second to last item usually)
        final lineStr = locationParts[locationParts.length - 2];
        final lineNumber = int.tryParse(lineStr) ?? 0;

        // Extract file path/name
        // E.g., package:getx_template/utils/app_log/log_utils.dart
        // Reconstruct path parts before line/col
        final pathParts = locationParts.sublist(0, locationParts.length - 2);
        final filePath = pathParts.join(':');
        final fileName = filePath.split('/').last;

        // Parse member info (e.g., "#1      MyClass.myMethod")
        var memberPart = line.substring(0, openParen).trim();
        // Remove frame index prefix like "#1      "
        if (memberPart.startsWith('#')) {
          final spaceIndex = memberPart.indexOf(RegExp(r'\s+'));
          if (spaceIndex != -1) {
            memberPart = memberPart.substring(spaceIndex).trim();
          }
        }

        return _extractClassAndMethod(memberPart, fileName, lineNumber);
      }

      // Web/Alternative Stack Frame parsing (e.g. "package:project/file.dart 10:11 class.method")
      final tokens = line.trim().split(RegExp(r'\s+'));
      if (tokens.length >= 3) {
        final filePath = tokens[0];
        final fileName = filePath.split('/').last;

        final lineCol = tokens[1].split(':');
        final lineNumber = lineCol.isNotEmpty ? (int.tryParse(lineCol[0]) ?? 0) : 0;

        final memberPart = tokens.sublist(2).join(' ');
        return _extractClassAndMethod(memberPart, fileName, lineNumber);
      }
    } catch (_) {
      // Fallback on parsing errors
    }
    return null;
  }

  /// Extracts class name and method name from the member path.
  static LogCallerInfo _extractClassAndMethod(String member, String fileName, int lineNumber) {
    if (member.isEmpty) {
      return LogCallerInfo(
        fileName: fileName,
        className: '',
        methodName: 'anonymous',
        lineNumber: lineNumber,
      );
    }

    // Clean up closure syntax like "MyClass.myMethod.<anonymous closure>"
    var cleanMember = member;
    if (cleanMember.contains('<anonymous closure>')) {
      cleanMember = cleanMember.replaceAll('.<anonymous closure>', '');
    }

    final parts = cleanMember.split('.');
    if (parts.length > 1) {
      // Typically: ClassName.methodName
      // Handle nested classes/methods if necessary by using sublist
      final methodName = parts.last;
      final className = parts.sublist(0, parts.length - 1).join('.');
      return LogCallerInfo(
        fileName: fileName,
        className: className,
        methodName: methodName,
        lineNumber: lineNumber,
      );
    } else {
      // Top level functions: main, anonymous functions
      return LogCallerInfo(
        fileName: fileName,
        className: '',
        methodName: cleanMember,
        lineNumber: lineNumber,
      );
    }
  }
}
