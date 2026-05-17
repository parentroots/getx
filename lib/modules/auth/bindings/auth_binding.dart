import 'package:get/get.dart';
import 'package:getx_template/modules/auth/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(AuthController.new, fenix: true);
  }
}
