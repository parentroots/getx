import 'package:dio/dio.dart';
import 'package:getx_template/utils/constants/api_constants.dart';
import 'package:getx_template/core/network/token_manager.dart';

class ApiInterceptor extends Interceptor {
  ApiInterceptor(this._tokenManager);

  final TokenManager _tokenManager;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenManager.accessToken;
    if (token != null && token.isNotEmpty) {
      options.headers[ApiConstants.authorization] =
          '${ApiConstants.bearer} $token';
    }
    handler.next(options);
  }
}
