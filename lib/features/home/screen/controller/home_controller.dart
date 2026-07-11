import 'package:get/get.dart';
import 'package:getx_template/shared/controllers/base_controller.dart';

class HomeController extends BaseController {
  final RxInt selectedIndex = 0.obs;
  final RxBool isSwitchOn = false.obs;

  void changeTab(int index) => selectedIndex.value = index;
  void toggleSwitch(bool val) => isSwitchOn.value = val;
}
