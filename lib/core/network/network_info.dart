import 'package:getx_template/services/connectivity/connectivity_service.dart';

class NetworkInfo {
  NetworkInfo(this._connectivityService);

  final ConnectivityService _connectivityService;

  Future<bool> get isConnected => _connectivityService.checkConnection();
}
