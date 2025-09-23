import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_curd/core/base/base_controller/base_controller.dart';
import 'package:getx_curd/core/base/base_reponse/base_response_data.dart';
import 'package:getx_curd/core/base/base_request/product_request.dart';
import 'package:getx_curd/features/detail_product/repository/detail_and_update_product_repository.dart';
import 'package:getx_curd/utils/show_popup.dart';
import 'package:getx_curd/utils/utils_widget.dart';
import 'package:intl/intl.dart';

import '../../../core/values/strings.dart';

class DetailAndUpdateProductController extends BaseGetxController {
  final currencyFormatter = NumberFormat('#,##0', 'vi_VN');
  late final DetailAndUpdateProductRepository
  _detailAndUpdateProductRepository = DetailAndUpdateProductRepository(this);
  final product = Rx<ProductData?>(null);
  late final ProductRequest _productRequest = ProductRequest();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController coverController = TextEditingController();
  final FocusNode nameFocus = FocusNode();
  final FocusNode priceFocus = FocusNode();
  final FocusNode quantityFocus = FocusNode();
  final FocusNode coverFocus = FocusNode();

  final RxString url = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final int productId = Get.arguments as int;
    fetchProductDetail(productId);
  }

  Future<void> fetchProductDetail(int productId) async {
    final result = await _detailAndUpdateProductRepository.getDetailProduct(
      productId,
    );
    if (result == null) return;
    product.value = result.data!;
    if (result.data != null) {
      nameController.text = result.data!.name!;
      priceController.text = result.data!.price!.toString();
      quantityController.text = result.data!.quantity!.toString();
      coverController.text = result.data!.cover!;
    }
    print('${priceController.text}');
  }

  void loadImage() async {
    url.value = coverController.text;
  }

  Future<void> updateProduct(
    int? productId, {
    required String name,
    required int price,
    required int quantity,
    required String coverUrl,
  }) async {
    _productRequest
      ..name = name
      ..price = price
      ..quantity = quantity
      ..cover = coverUrl;
    final result = await _detailAndUpdateProductRepository.getUpdateProduct(
      productId!,
      _productRequest,
    );
    if (result == null || result.success == false) {
      UtilsWidget.showSnackBar(
        title: AppStrings.title,
        message: AppStrings.messageErrorUpdate,
      );
      return;
    }
    product.value = ProductData(
      name: name,
      price: price,
      quantity: quantity,
      cover: coverUrl,
    );

    UtilsWidget.showSnackBar(
      title: AppStrings.title,
      message: AppStrings.messageUpdate,
    );
    return;
  }

  Future<bool> deleteProduct(int productID) async {
    final isDelete = await showDiaLog();
    if (isDelete == true) {
      final result = await _detailAndUpdateProductRepository.deleteProduct(
        productID,
      );
      if (result?.success == null || result?.success == false) {
        ShowPopup.showDiaLogNotifyton(
          AppStrings.title,
          AppStrings.messageErrorRequest,
          AppStrings.okButton,
          null,
        );
        return false;
      }
      if (result?.success == true) {
        Get.back(result: true);
        UtilsWidget.showSnackBar(
          title: AppStrings.title,
          message: AppStrings.messageUpdate,
        );
        return true;
      }
    }
    return false;
  }

  Future<bool> showDiaLog() async {
    final completer = Completer<bool>();
    ShowPopup.showDiaLogConfirm(
      AppStrings.title,
      AppStrings.messageDelete,
      () async {
        if (!completer.isCompleted) completer.complete(false);
      },
      () async {
        if (!completer.isCompleted) completer.complete(true);
      },
    );
    return completer.future;
  }
}
