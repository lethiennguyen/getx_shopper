import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_curd/core/base/base_controller/base_controller.dart';

class HomeController extends BaseGetxController with GetSingleTickerProviderStateMixin {
  RxInt currentIndex = 0.obs;
  late TabController tabCtrl;
  RxBool onWillPop = false.obs;
  RxBool onWillPopScope = false.obs;

  void changeTab(int index) {
    currentIndex.value = index;
    tabCtrl.index = index;
  }
  @override
  void onInit() {
    super.onInit();
    tabCtrl = TabController(length: 2, vsync: this);
  }

  @override
  void onClose() {
    tabCtrl.dispose();
    super.onClose();
  }
}
