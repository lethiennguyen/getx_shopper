import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:getx_curd/core/base/base_controller/base_controller.dart';
import 'package:getx_curd/core/base/base_request/product_request.dart';
import 'package:getx_curd/core/router/app_router.dart';
import 'package:getx_curd/core/values/assets.dart';
import 'package:getx_curd/features/create_product/repository/create_product_repository.dart';

import '../../../core/values/strings.dart';
import '../../../utils/show_popup.dart';
import '../../../utils/utils_widget.dart';

class CreateProductController extends BaseGetxController {
  late final CreateProductRepository _createProductRepository =
      CreateProductRepository(this);
  late final ProductRequest _productRequest = ProductRequest();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController coverController = TextEditingController();
  final RxString url = ''.obs;

  final FocusNode nameFocus = FocusNode();
  final FocusNode priceFocus = FocusNode();
  final FocusNode quantityFocus = FocusNode();
  final FocusNode coverFocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  final autoValidateMode = AutovalidateMode.disabled.obs;

  void loadImage() async {
    url.value = coverController.text;
  }

  Future<void> createProduct() async {
    autoValidateMode.value = AutovalidateMode.always;

    if (!(formKey.currentState?.validate() ?? false)) {
      UtilsWidget.showSnackBar(
        title: AppStrings.title,
        message: AppStrings.messageValidateCreate,
      );
      return;
    }
    final name = nameController;
    final price = priceController;
    final quantity = quantityController;
    final cover = coverController;
    _productRequest
      ..name = name.text
      ..price = int.tryParse(price.text)
      ..quantity = int.tryParse(quantity.text)
      ..cover = cover.text;
    final result = await _createProductRepository.postCreateProduct(
      _productRequest,
    );
    if (result?.success == false || result == null) {
      ShowPopup.showDiaLogNotifyton(
        AppStrings.title,
        AppStrings.messageError,
        AppStrings.okButton,
        null,
      );
      return;
    }
    if (result.success == true) {
      UtilsWidget.showSnackBar(
        title: AppStrings.title,
        message: AppStrings.messageUpdate,
      );
      Get.offAllNamed(AppRouter.routerHome);
      return;
    }
  }
}
