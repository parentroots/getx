import 'package:dio/dio.dart';
import 'package:getx_template/utils/app_log/app_logger.dart';

/// A complete [Interceptor] for logging [Dio] HTTP requests, responses, and errors.
///
/// Automatically tracks API latency, logs request methods, URLs, headers,
/// bodies, response bodies, status codes, and error exceptions.
class DioLogInterceptor extends Interceptor {
  /// Unique key for store request initiation timestamp in Dio request options.
  static const String _startTimeKey = 'dio_request_start_time';

  const DioLogInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Record request start time
    options.extra[_startTimeKey] = DateTime.now().millisecondsSinceEpoch;

    // Log the API request
    log.apiRequest(
      method: options.method.toUpperCase(),
      url: options.uri.toString(),
      headers: options.headers,
      body: options.data,
    );

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final startTime = response.requestOptions.extra[_startTimeKey] as int?;
    final duration = startTime != null
        ? Duration(milliseconds: DateTime.now().millisecondsSinceEpoch - startTime)
        : Duration.zero;

    // Log the API response
    log.apiResponse(
      statusCode: response.statusCode ?? -1,
      duration: duration,
      body: response.data,
    );

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final startTime = err.requestOptions.extra[_startTimeKey] as int?;
    final duration = startTime != null
        ? Duration(milliseconds: DateTime.now().millisecondsSinceEpoch - startTime)
        : Duration.zero;

    // Log response if one was received
    if (err.response != null) {
      log.apiResponse(
        statusCode: err.response!.statusCode ?? -1,
        duration: duration,
        body: err.response!.data,
      );
    }

    // Format error description
    final errorDescription = StringBuffer()
      ..writeln('DioException [${err.type.name}]: ${err.message}')
      ..writeln('URI: ${err.requestOptions.uri}')
      ..writeln('Method: ${err.requestOptions.method}');

    if (err.error != null) {
      errorDescription.writeln('Underlying Error: ${err.error}');
    }

    // Log the exception details
    log.e(
      errorDescription.toString(),
      err,
      err.stackTrace,
    );

    super.onError(err, handler);
  }
}
