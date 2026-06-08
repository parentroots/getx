// ─── Base ────────────────────────────────────

class AppException implements Exception {
  const AppException(this.message, {this.code, this.details});

  final String message;
  final String? code;
  final Object? details;

  @override
  String toString() => code == null ? message : '[$code] $message';
}

// ─── Network (catch-all) ─────────────────────

class NetworkException extends AppException {
  const NetworkException(super.message, {this.statusCode, super.code, super.details});
  final int? statusCode;
}

// ─── HTTP Status Code Exceptions ─────────────

class BadRequestException extends NetworkException {
  const BadRequestException([String message = 'Bad request', Object? details])
      : super(message, statusCode: 400, details: details);
}

class UnauthorizedException extends NetworkException {
  const UnauthorizedException([String message = 'Session expired. Please log in again.'])
      : super(message, statusCode: 401);
}

class ForbiddenException extends NetworkException {
  const ForbiddenException([String message = 'You do not have permission for this action.'])
      : super(message, statusCode: 403);
}

class NotFoundException extends NetworkException {
  const NotFoundException([String message = 'The requested resource was not found.'])
      : super(message, statusCode: 404);
}

class ConflictException extends NetworkException {
  const ConflictException([String message = 'A conflict occurred with the resource.'])
      : super(message, statusCode: 409);
}

class ValidationException extends NetworkException {
  const ValidationException(String message, {Object? details})
      : super(message, statusCode: 422, details: details);
}

class TooManyRequestsException extends NetworkException {
  const TooManyRequestsException([String message = 'Too many requests. Try again later.'])
      : super(message, statusCode: 429);
}

class ServerException extends NetworkException {
  const ServerException([String message = 'Server error. Please try again later.', int? statusCode])
      : super(message, statusCode: statusCode ?? 500);
}

// ─── Connection Exceptions ───────────────────

class NoInternetException extends NetworkException {
  const NoInternetException([String message = 'No internet connection.'])
      : super(message);
}

class TimeoutException extends NetworkException {
  const TimeoutException([String message = 'Request timed out. Please try again.'])
      : super(message);
}

class RequestCancelledException extends NetworkException {
  const RequestCancelledException([String message = 'Request was cancelled.'])
      : super(message);
}
