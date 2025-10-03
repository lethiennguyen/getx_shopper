import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:getx_curd/core/values/colors.dart';
import 'package:getx_curd/core/values/dimens.dart';
import 'package:getx_curd/core/values/strings.dart';
import 'package:getx_curd/features/model/shopping_cart_operation_model.dart';
import 'package:getx_curd/features/shopping_cart/controller/shopping_cart_controller.dart';
import 'package:getx_curd/features/shopping_cart/model/hive_shopping_cart.dart';
import 'package:getx_curd/utils/utils_text.dart';
import 'package:getx_curd/utils/utils_widget.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../utils/currency_utils.dart';
import '../../../utils/widgets/size_box.dart';

part 'shopping_cart_views.dart';

class ShoppingCartPage extends GetView<ShoppingCartController> {
  const ShoppingCartPage({super.key});

  @override
  ShoppingCartController get controller => Get.put(ShoppingCartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(controller),
      body: _buildShoppingCart(controller),
      bottomNavigationBar: _bottomNavigatorBar(controller),
      backgroundColor: AppColors.colorWhite,
    );
  }
}
