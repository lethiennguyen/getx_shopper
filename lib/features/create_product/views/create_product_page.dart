import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_curd/core/values/assets.dart';
import 'package:getx_curd/features/create_product/controller/create_product_cotroller.dart';
import 'package:getx_curd/utils/widgets/size_box.dart';

import '../../../core/values/colors.dart';
import '../../../core/values/dimens.dart';
import '../../../core/values/strings.dart';
import '../../../shares/enum/enum_field.dart';
import '../../../utils/utils_widget.dart';
import '../../model/text_input_model.dart';

part 'create_product_views.dart';

class CreateProductPage extends GetView<CreateProductController> {
  const CreateProductPage({super.key});

  @override
  CreateProductController get controller => Get.put(CreateProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: AppBar(backgroundColor: AppColors.colorWhite),
      body: _buildBody(controller),
      bottomNavigationBar: _buttonBack(controller),
    );
  }
}
