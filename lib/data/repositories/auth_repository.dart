import 'package:getx_template/core/network/api_endpoint/api_endpoint.dart';
import 'package:getx_template/data/repositories/base_repository.dart';

class AuthRepository extends BaseRepository {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await apiClient.post(
      ApiEndpoint.login,
      data: {
        'email': email,
        'password': password,
      },
    );
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await apiClient.post(
      ApiEndpoint.register,
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
    );
    return response.data as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final response = await apiClient.post(
      ApiEndpoint.changePassword,
      data: {
        'oldPassword': currentPassword,
        'newPassword': newPassword,
      },
    );
    return response.data as Map<String, dynamic>;
  }
}

