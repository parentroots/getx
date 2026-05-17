import 'package:get/get.dart';
import 'package:getx_template/modules/profile/controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(ProfileController.new, fenix: true);
  }
}
