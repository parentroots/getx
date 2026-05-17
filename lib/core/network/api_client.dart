import 'package:dio/dio.dart';
import 'package:getx_template/core/config/app_config.dart';
import 'package:getx_template/core/constants/api_constants.dart';
import 'package:getx_template/core/errors/app_exception.dart';
import 'package:getx_template/core/network/api_interceptor.dart';
import 'package:getx_template/core/network/token_manager.dart';

/// A Singleton API Client that handles all HTTP requests using Dio.
class ApiClient {
  // Private constructor for singleton
  ApiClient._internal();

  // Singleton instance
  static final ApiClient _instance = ApiClient._internal();

  // Public getter for the instance
  static ApiClient get instance => _instance;

  late Dio _dio;

  /// Initialize the API Client with configuration and interceptors.
  /// Must be called before making any requests.
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

    // Add interceptors
    _dio.interceptors.add(ApiInterceptor(tokenManager));
    if (config.enableNetworkLogs) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          requestHeader: true,
        ),
      );
    }
  }

  /// Expose Dio directly if needed
  Dio get dio => _dio;

  /// Performs a GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _guard(() => _dio.get<T>(
          path,
          queryParameters: queryParameters,
          options: options,
        ));
  }

  /// Performs a POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _guard(() => _dio.post<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
        ));
  }

  /// Performs a PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _guard(() => _dio.put<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
        ));
  }

  /// Performs a PATCH request
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _guard(() => _dio.patch<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
        ));
  }

  /// Performs a DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _guard(() => _dio.delete<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
        ));
  }

  /// Uploads a file using multipart form data
  Future<Response<T>> multipartUpload<T>(
    String path, {
    required FormData formData,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Function(int, int)? onSendProgress,
  }) {
    final multipartOptions = options ?? Options();
    multipartOptions.headers ??= {};
    multipartOptions.headers![ApiConstants.contentType] = 'multipart/form-data';

    return _guard(() => _dio.post<T>(
          path,
          data: formData,
          queryParameters: queryParameters,
          options: multipartOptions,
          onSendProgress: onSendProgress,
        ));
  }

  /// Download a file
  Future<Response> download(
    String urlPath,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    Function(int, int)? onReceiveProgress,
  }) {
    return _guard(() => _dio.download(
          urlPath,
          savePath,
          queryParameters: queryParameters,
          options: options,
          onReceiveProgress: onReceiveProgress,
        ));
  }

  /// Wrapper to catch standard Dio errors and throw [NetworkException]
  Future<Response<T>> _guard<T>(Future<Response<T>> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      final status = error.response?.statusCode;
      throw NetworkException(
        error.response?.statusMessage ?? error.message ?? 'Network request failed',
        code: status?.toString(),
        details: error.response?.data,
      );
    } catch (e) {
      throw NetworkException(e.toString());
    }
  }
}
