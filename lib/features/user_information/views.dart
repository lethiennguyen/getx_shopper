import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_curd/core/values/colors.dart';
import 'package:getx_curd/features/user_information/controller/user_information_controller.dart';
import 'package:getx_curd/utils/utils_text.dart';

class UserInformationView extends GetView<UserInformationController> {
  const UserInformationView({super.key});

  @override
  UserInformationController get controller =>
      Get.put(UserInformationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: AppBar(
        backgroundColor: AppColors.colorOrange,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.door_back_door_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              controller.logout();
            },
          ),
        ],
      ),
      body: const Center(child: TextUtils(text: 'Thông tin người dùng')),
    );
  }
}
