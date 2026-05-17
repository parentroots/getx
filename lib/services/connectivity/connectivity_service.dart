import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityService extends GetxService {
  final Connectivity _connectivity = Connectivity();
  final RxBool isConnected = true.obs;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  @override
  void onInit() {
    super.onInit();
    _subscription = _connectivity.onConnectivityChanged.listen(_setStatus);
    checkConnection();
  }

  Future<bool> checkConnection() async {
    final result = await _connectivity.checkConnectivity();
    _setStatus(result);
    return isConnected.value;
  }

  void _setStatus(List<ConnectivityResult> results) {
    isConnected.value = results.any(
      (result) => result != ConnectivityResult.none,
    );
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
