import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_curd/core/base/base_controller/base_controller.dart';
import 'package:getx_curd/core/base/base_reponse/product_response_data.dart';
import 'package:getx_curd/core/base/base_request/product_request.dart';
import 'package:getx_curd/features/detail_product/repository/detail_and_update_product_repository.dart';
import 'package:getx_curd/features/image_picker_load/repository/image_picker_repository.dart';
import 'package:getx_curd/features/image_picker_load/request/image_upload_request.dart';
import 'package:getx_curd/utils/show_popup.dart';
import 'package:getx_curd/utils/utils_widget.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/values/key.dart';
import '../../../core/values/strings.dart';
import '../../shopping_cart/model/hive_shopping_cart.dart';

class DetailAndUpdateProductController extends BaseGetxController {
  late final DetailAndUpdateProductRepository
  _detailAndUpdateProductRepository = DetailAndUpdateProductRepository(this);

  late final ImageRepository _repositoryImage = ImageRepository(this);

  final ImageUploadRequest _requestImage = ImageUploadRequest();
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

  late final Box<CartItem> box;
  final RxList<CartItem> items = <CartItem>[].obs;
  final RxInt cartCount = 0.obs;
  @override
  void onInit() {
    super.onInit();
    final int productId = Get.arguments as int;
    fetchProductDetail(productId);
    box = Hive.box<CartItem>(HiveBoxNames.cartbox);
    shoppingCartCount();
  }

  void shoppingCartCount() {
    cartCount.value = box.length;
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
  }

  Future<void> upImage() async {
    final upImage = await _repositoryImage.pickImage(ImageSource.gallery);
    if (upImage == null) return;
    _requestImage
      ..imagePath = upImage.path
      ..uploadPreset = _repositoryImage.uploadPreset;

    final urlImage = await _repositoryImage.uploadToCloudinary(_requestImage);
    if (urlImage == null) return;
    url.value = urlImage;
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

  Future<void> deleteProduct(int productID) async {
    final isDelete = await showDiaLog();
    if (isDelete) {
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
      }
      if (result!.success) {
        removeById(productID);
        Get.back(result: true);
        UtilsWidget.showSnackBar(
          title: AppStrings.title,
          message: AppStrings.messageNotiDelete,
        );
      }
    }
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

  int? findKeyByProductId(int productId) {
    final key = box.keys.firstWhere((k) => box.get(k)!.id == productId);
    if (key != null) {
      return key;
    } else {
      return null;
    }
  }

  /// xóa theo id
  Future<void> removeById(int id) async {
    final key = findKeyByProductId(id);
    if (key == null) return;

    // Xóa trong Hive (theo key trong box)
    await box.delete(key);
  }

  Future<void> addItem(CartItem item) async {
    // Kiểm tra trong box chứ không chỉ trong items
    final exists = box.values.any((e) => e.id == item.id);
    print("${item.id}");
    if (exists) {
      UtilsWidget.showSnackBar(
        title: AppStrings.title,
        message: AppStrings.messageAddItemFail,
      );
      return;
    }

    await box.add(item);
    items.add(item);
    shoppingCartCount();

    UtilsWidget.showSnackBar(
      title: AppStrings.title,
      message: AppStrings.messageAddItem,
    );
  }
}
