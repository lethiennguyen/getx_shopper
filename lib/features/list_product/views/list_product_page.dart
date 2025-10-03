import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:getx_curd/core/base/base_reponse/product_response_data.dart';
import 'package:getx_curd/core/router/app_router.dart';
import 'package:getx_curd/core/values/colors.dart';
import 'package:getx_curd/core/values/dimens.dart';
import 'package:getx_curd/core/values/strings.dart';
import 'package:getx_curd/features/list_product/controller/list_product_controller.dart';
import 'package:getx_curd/features/model/app_bar_model.dart';
import 'package:getx_curd/features/shopping_cart/controller/shopping_cart_controller.dart';
import 'package:getx_curd/utils/skeleton.dart';
import 'package:getx_curd/utils/utils_text.dart';
import 'package:getx_curd/utils/utils_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/values/assets.dart';
import '../../../utils/currency_utils.dart';
import '../../../utils/widgets/size_box.dart';
import '../../shopping_cart/model/hive_shopping_cart.dart';

part 'list_product_views.dart';

class ListProductPage extends GetView<ListProductController> {
  const ListProductPage({super.key});

  @override
  ListProductController get controller => Get.put(ListProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      appBar: _appBar(controller),
      body: _buildListProduct(controller),
      floatingActionButton: _buildFloatingActionButton(controller.onRefresh),
    );
  }
}
