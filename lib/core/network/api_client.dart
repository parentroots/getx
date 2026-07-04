import 'package:dio/dio.dart';
import 'package:getx_template/core/config/app_config.dart';
import 'package:getx_template/core/constants/api_constants.dart';
import 'package:getx_template/core/errors/app_exception.dart';
import 'package:getx_template/core/network/api_interceptor.dart';
import 'package:getx_template/core/network/token_manager.dart';
import 'package:getx_template/core/utils/helper/logger_helper.dart';

/// Singleton API Client — wraps Dio with typed error handling.
class ApiClient {
  ApiClient._internal();
  static final ApiClient _instance = ApiClient._internal();
  static ApiClient get instance => _instance;

  late Dio _dio;

  /// Must be called once at app startup before making requests.
  void init({required AppConfig config, required TokenManager tokenManager}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: config.apiBaseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        responseType: ResponseType.json,
        headers: {
          'Accept': ApiConstants.applicationJson,
          ApiConstants.contentType: ApiConstants.applicationJson,
        },
      ),
    );

    _dio.interceptors.add(ApiInterceptor(tokenManager));
    if (config.enableNetworkLogs) {
      _dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true, requestHeader: true),
      );
    }
  }

  Dio get dio => _dio;

  // ─── HTTP Methods ──────────────────────────────

  Future<Response<T>> get<T>(String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _request(() => _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    ));
  }

  Future<Response<T>> post<T>(String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _request(() => _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    ));
  }

  Future<Response<T>> put<T>(String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _request(() => _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    ));
  }

  Future<Response<T>> patch<T>(String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _request(() => _dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    ));
  }

  Future<Response<T>> delete<T>(String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _request(() => _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    ));
  }

  Future<Response<T>> multipartUpload<T>(String path, {
    required FormData formData,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
  }) {
    final uploadOptions = options ?? Options();
    uploadOptions.headers ??= {};
    uploadOptions.headers![ApiConstants.contentType] = 'multipart/form-data';

    return _request(() => _dio.post<T>(
      path,
      data: formData,
      queryParameters: queryParameters,
      options: uploadOptions,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
    ));
  }

  Future<Response> download(String urlPath, String savePath, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) {
    return _request(() => _dio.download(
      urlPath,
      savePath,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    ));
  }

  // ─── Error Handling ────────────────────────────

  /// Wraps every request — catches Dio errors and maps them to typed exceptions.
  Future<Response<T>> _request<T>(Future<Response<T>> Function() call) async {
    try {
      return await call();
    } on DioException catch (e) {
      throw _handleDioError(e);
    } on AppException {
      rethrow;
    } catch (e, stack) {
      LoggerHelper.error('Unexpected network error', error: e, stackTrace: stack);
      throw NetworkException('An unexpected error occurred.', details: e);
    }
  }

  /// Maps DioException type → our typed exception.
  AppException _handleDioError(DioException e) {
    switch (e.type) {
      // Timeouts
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return const TimeoutException();

      // User cancelled request
      case DioExceptionType.cancel:
        return const RequestCancelledException();

      // No internet / DNS failure
      case DioExceptionType.connectionError:
        return const NoInternetException();

      // Invalid SSL certificate
      case DioExceptionType.badCertificate:
        return const NetworkException('SSL certificate verification failed.');

      // Server responded with an error status code
      case DioExceptionType.badResponse:
        return _handleStatusCode(e);

      // Catch-all (SocketException, etc.)
      case DioExceptionType.unknown:
        if (_isConnectionError(e.message)) return const NoInternetException();
        return NetworkException('An unexpected network error occurred.', details: e.message);
    }
  }

  /// Maps HTTP status codes → our typed exception with server message.
  AppException _handleStatusCode(DioException e) {
    final status = e.response?.statusCode;
    final body = e.response?.data;
    final msg = _extractMessage(body);

    return switch (status) {
      400 => BadRequestException(msg ?? 'Bad request', body),
      401 => UnauthorizedException(msg ?? 'Session expired. Please log in again.'),
      403 => ForbiddenException(msg ?? 'You do not have permission for this action.'),
      404 => NotFoundException(msg ?? 'The requested resource was not found.'),
      409 => ConflictException(msg ?? 'A conflict occurred with the resource.'),
      422 => ValidationException(msg ?? 'The submitted data is invalid.', details: body),
      429 => TooManyRequestsException(msg ?? 'Too many requests. Try again later.'),
      500 => ServerException(msg ?? 'Server error. Please try again later.', status),
      _ => NetworkException(msg ?? 'Request failed (status $status)', statusCode: status, details: body),
    };
  }

  /// Checks if an unknown error is actually a connection issue.
  bool _isConnectionError(String? message) {
    if (message == null) return false;
    const patterns = ['SocketException', 'Connection refused', 'Network is unreachable', 'Failed host lookup'];
    return patterns.any(message.contains);
  }

  /// Extracts a human-readable error message from common API response shapes:
  ///   { "message": "..." }
  ///   { "error": "..." }
  ///   { "error": { "message": "..." } }
  ///   { "errors": { "email": ["taken"] } }
  ///   { "msg": "..." }
  String? _extractMessage(dynamic data) {
    if (data is String && data.isNotEmpty) return data;
    if (data is! Map<String, dynamic>) return null;

    // Try common keys
    if (data['message'] is String) return data['message'] as String;
    if (data['error'] is String) return data['error'] as String;
    if (data['msg'] is String) return data['msg'] as String;

    // Nested: { "error": { "message": "..." } }
    if (data['error'] is Map) {
      final nested = data['error'] as Map;
      if (nested['message'] is String) return nested['message'] as String;
    }

    // Validation: { "errors": { "email": ["taken"], "name": ["required"] } }
    if (data['errors'] is Map) {
      final errors = data['errors'] as Map;
      final messages = <String>[];
      for (final value in errors.values) {
        if (value is List) {
          messages.addAll(value.whereType<String>());
        } else if (value is String) {
          messages.add(value);
        }
      }
      if (messages.isNotEmpty) return messages.join(', ');
    }

    return null;
  }
}
