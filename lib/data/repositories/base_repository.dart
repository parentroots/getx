import 'package:getx_template/core/network/api_client.dart';

abstract class BaseRepository {
  BaseRepository(this.apiClient);

  final ApiClient apiClient;
}
