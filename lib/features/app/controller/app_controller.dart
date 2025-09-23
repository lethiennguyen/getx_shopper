import 'package:get/get.dart';
import 'package:getx_curd/core/base/base_controller/base_controller.dart';
import 'package:getx_curd/core/router/app_router.dart';
import 'package:hive/hive.dart';

import '../../../core/base/base_repository/base_connect_api.dart';
import '../../../core/values/key.dart';
import '../../login/controller/login_controller.dart';
import '../../login/repository/login_repository.dart';

class AppController extends BaseGetxController {
  final RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initApp();
  }

  Future<void> _initApp() async {

    Get.put(BaseConnectAPI(), permanent: true);

    final authBox = await Hive.openBox(HiveBoxNames.auth);
    final token = authBox.get(HiveKeys.token, defaultValue: '') ;
    await Future.delayed(Duration(milliseconds: 2000));
    if(token != ''){
      Get.offAllNamed(AppRouter.routerHome);
    }
    else{
      Get.offAllNamed(AppRouter.routerLogin);
    }
  }

  Future<void> setLoggedIn(bool value) async {
    final authBox = Hive.box(HiveBoxNames.auth);
    await authBox.put('isLoggedIn', value);
    isLoggedIn.value = value;
  }
}
