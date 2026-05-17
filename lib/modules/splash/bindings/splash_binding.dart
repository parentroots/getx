import 'package:get/get.dart';
import 'package:getx_template/modules/splash/controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(SplashController.new);
  }
}
