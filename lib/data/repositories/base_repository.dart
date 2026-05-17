import 'package:getx_template/core/network/api_client.dart';
import 'package:getx_template/core/network/socket_client.dart';

abstract class BaseRepository {
  /// Base Repository provides direct access to the global Singleton Network clients.
  BaseRepository();

  /// Access to the HTTP API Client (Dio)
  final ApiClient apiClient = ApiClient.instance;

  /// Access to the WebSockets/Socket.IO Client
  final SocketClient socketClient = SocketClient.instance;
}
