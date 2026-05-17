class AppException implements Exception {
  const AppException(this.message, {this.code, this.details});

  final String message;
  final String? code;
  final Object? details;

  @override
  String toString() => code == null ? message : '[$code] $message';
}

class NetworkException extends AppException {
  const NetworkException(super.message, {super.code, super.details});
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([super.message = 'Session expired']);
}

class ValidationException extends AppException {
  const ValidationException(super.message, {super.details});
}
