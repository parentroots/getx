import 'package:getx_template/core/constants/storage_keys.dart';
import 'package:getx_template/services/storage/secure_storage_service.dart';

class TokenManager {
  TokenManager(this._secureStorage);

  final SecureStorageService _secureStorage;

  Future<String?> get accessToken =>
      _secureStorage.read(StorageKeys.accessToken);

  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    await _secureStorage.write(StorageKeys.accessToken, accessToken);
    if (refreshToken != null) {
      await _secureStorage.write(StorageKeys.refreshToken, refreshToken);
    }
  }

  Future<void> clear() async {
    await _secureStorage.delete(StorageKeys.accessToken);
    await _secureStorage.delete(StorageKeys.refreshToken);
  }
}
