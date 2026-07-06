import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_template/shared/controllers/base_controller.dart';

class MainBottomNavController extends BaseController {
  final RxInt currentIndex = 0.obs;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void changeTab(int index) {
    currentIndex.value = index;
  }

  void openDrawer() {
    scaffoldKey.currentState?.openDrawer();
  }
}
