
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getx_curd/core/base/base_controller/base_controller.dart';
import 'package:getx_curd/core/router/app_router.dart';
import 'package:getx_curd/core/values/key.dart';
import 'package:hive/hive.dart';

class UserInformationController extends BaseGetxController{

  Future<void> logout() async {
    final box = Hive.box(HiveBoxNames.auth);
    await box.delete(HiveKeys.token);
    box.put(HiveKeys.isLoggedIn, false);

    Get.offAllNamed(AppRouter.routerLogin);
  }

}