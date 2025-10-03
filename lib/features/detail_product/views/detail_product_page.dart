import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getx_curd/core/base/base_request/product_request.dart';
import 'package:getx_curd/core/router/app_router.dart';
import 'package:getx_curd/core/values/strings.dart';
import 'package:getx_curd/features/detail_product/controller/detail_and_update_product_controller.dart';
import 'package:getx_curd/features/image_picker_load/image_picker_views.dart';
import 'package:getx_curd/features/shopping_cart/controller/shopping_cart_controller.dart';
import 'package:getx_curd/utils/utils_widget.dart';
import 'package:getx_curd/utils/widgets/size_box.dart';

import '../../../core/values/assets.dart';
import '../../../core/values/colors.dart';
import '../../../core/values/dimens.dart';
import '../../../shares/enum/enum_field.dart';
import '../../../utils/currency_utils.dart';
import '../../../utils/utils_text.dart';
import '../../model/text_input_model.dart';
import '../../shopping_cart/model/hive_shopping_cart.dart';

part 'detail_product_views.dart';
part 'update_product_bottomsheet.dart';

class DetailProductPage extends GetView<DetailAndUpdateProductController> {
  const DetailProductPage({super.key});

  @override
  DetailAndUpdateProductController get controller =>
      Get.put(DetailAndUpdateProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(controller),
      body: _bodyFormProduct(controller),
      bottomNavigationBar: _buildBottomNavigationBar(controller),
    );
  }
}
