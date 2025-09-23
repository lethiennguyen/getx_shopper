import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:getx_curd/features/app/controller/app_controller.dart';

import '../../../core/base/base_repository/base_connect_api.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<BaseConnectAPI>(BaseConnectAPI(), permanent: true);
    Get.put<AppController>(AppController());
  }
}