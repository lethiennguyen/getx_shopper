import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getx_curd/core/values/dimens.dart';
import 'package:getx_curd/core/values/strings.dart';
import 'package:getx_curd/utils/widgets/size_box.dart';

import '../../../core/values/assets.dart';
import '../../../core/values/colors.dart';
import '../../../shares/enum/enum_field.dart';
import '../../../utils/utils_widget.dart';
import '../../model/text_input_model.dart';
import '../controller/login_controller.dart';

part 'login_widget.dart';

class MyHomeLogin extends GetView<LoginController> {
  const MyHomeLogin({super.key});

  @override
  LoginController get controller => Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: formLogin(controller),
      bottomNavigationBar: _formBottomNavigate(),
    );
  }
}
