import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:getx_curd/core/values/colors.dart';
import 'package:getx_curd/features/app/controller/app_controller.dart';
import '../../core/values/assets.dart';

class SplashPage extends GetView<AppController> {
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put<AppController>(AppController(), permanent: true);
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: Center(
        child: SvgPicture.asset(IconsAssets.logo, width: 158, height: 37),
      ),
    );
  }
}
