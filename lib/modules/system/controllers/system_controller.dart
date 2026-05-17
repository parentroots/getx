import 'package:get/get.dart';
import 'package:getx_template/services/connectivity/connectivity_service.dart';
import 'package:getx_template/shared/controllers/base_controller.dart';

class SystemController extends BaseController {
  Future<void> retryConnection() async {
    final connected = await Get.find<ConnectivityService>().checkConnection();
    if (connected && Get.key.currentState?.canPop() == true) {
      Get.back<void>();
    }
  }
}
