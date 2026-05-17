import 'package:dio/dio.dart';
import 'package:getx_template/app/app_config.dart';
import 'package:getx_template/core/constants/api_constants.dart';
import 'package:getx_template/core/errors/app_exception.dart';
import 'package:getx_template/core/network/api_interceptor.dart';
import 'package:getx_template/core/network/token_manager.dart';

class ApiClient {
  ApiClient({required AppConfig config, required TokenManager tokenManager})
    : dio = Dio(
        BaseOptions(
          baseUrl: config.apiBaseUrl,
          connectTimeout: ApiConstants.connectTimeout,
          receiveTimeout: ApiConstants.receiveTimeout,
          responseType: ResponseType.json,
          headers: {'Accept': 'application/json'},
        ),
      ) {
    dio.interceptors.add(ApiInterceptor(tokenManager));
    if (config.enableNetworkLogs) {
      dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true),
      );
    }
  }

  final Dio dio;

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) {
    return _guard(() => dio.get<T>(path, queryParameters: queryParameters));
  }

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _guard(
      () => dio.post<T>(path, data: data, queryParameters: queryParameters),
    );
  }

  Future<Response<T>> put<T>(String path, {Object? data}) {
    return _guard(() => dio.put<T>(path, data: data));
  }

  Future<Response<T>> patch<T>(String path, {Object? data}) {
    return _guard(() => dio.patch<T>(path, data: data));
  }

  Future<Response<T>> delete<T>(String path, {Object? data}) {
    return _guard(() => dio.delete<T>(path, data: data));
  }

  Future<Response<T>> _guard<T>(Future<Response<T>> Function() request) async {
    try {
      return await request();
    } on DioException catch (error) {
      final status = error.response?.statusCode;
      throw NetworkException(
        error.response?.statusMessage ??
            error.message ??
            'Network request failed',
        code: status?.toString(),
        details: error.response?.data,
      );
    }
  }
}
