import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_curd/core/router/app_router.dart';
import 'package:getx_curd/features/home/controller/home_controller.dart';
import 'package:getx_curd/features/list_product/views/list_product_page.dart';
import 'package:getx_curd/features/user_information/views.dart';
import '../../../core/values/colors.dart';
import '../../../utils/widgets/size_box.dart';

part 'home_views.dart';

class MyHomePage extends GetView<HomeController> {
  const MyHomePage({super.key});
  @override
  HomeController get controller => Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: controller.onWillPop.value,
      child: Scaffold(
        backgroundColor: AppColors.colorWhite,
        body: _buildBody(controller),
        bottomNavigationBar: _buildBottomNavigationBar(controller),
      ),
    );
  }
}
