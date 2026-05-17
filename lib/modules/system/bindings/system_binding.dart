import 'package:get/get.dart';
import 'package:getx_template/modules/system/controllers/system_controller.dart';

class SystemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SystemController>(SystemController.new);
  }
}
