import 'package:get/get.dart';
import 'package:getx_curd/core/base/base_controller/base_refesh_controller.dart';
import 'package:getx_curd/core/base/base_reponse/product_response_data.dart';
import 'package:getx_curd/core/base/base_request/base_request_model.dart';
import 'package:getx_curd/core/values/const.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

import '../../../core/values/key.dart';
import '../../../core/values/strings.dart';
import '../../../utils/show_popup.dart';
import '../../../utils/utils_widget.dart';
import '../../shopping_cart/model/hive_shopping_cart.dart';
import '../repository/list_product_repository.dart';

class ListProductController extends BaseRefreshGetxController {
  late final ListProductRepository _listProduct = ListProductRepository(this);
  RxList<ProductData> listProduct = <ProductData>[].obs;
  RxBool isLoadMore = true.obs;
  int pageIndex = 1;

  late final Box<CartItem> _box;
  final RxList<CartItem> items = <CartItem>[].obs;
  final RxInt cartCount = 0.obs;
  @override
  void onInit() {
    super.onInit();
    onRefresh();
    _box = Hive.box<CartItem>(HiveBoxNames.cartbox);
    shoppingCartCount();
  }

  @override
  Future<void> onRefresh() async {
    showLoading();
    pageIndex = AppConst.pageIndex1;
    isLoadMore.value = true;
    await _fetchData();
    refreshController.refreshCompleted();
    shoppingCartCount();
    hideLoading();
  }

  @override
  Future<void> onLoadMore() async {
    pageIndex++;
    await _fetchData();
    refreshController.loadComplete();
  }

  void shoppingCartCount() {
    cartCount.value = _box.length;
  }

  Future<void> _fetchData() async {
    final request = BaseRequestListModel(page: pageIndex, pageSize: 10);
    final result = await _listProduct.getListProduct(request);
    if (result == null) {
      listProduct.clear();
      ShowPopup.showDiaLogNotifyton(
        AppStrings.title,
        AppStrings.messageErrorRequest,
        AppStrings.okButton,
        null,
      );
      return;
    }
    if (pageIndex == AppConst.pageIndex1) {
      listProduct.clear();
    }
    listProduct.addAll(result.data);
  }

  Future<void> addItem(CartItem item) async {
    // Kiểm tra trong box chứ không chỉ trong items
    final exists = _box.values.any((e) => e.id == item.id);
    if (exists) {
      UtilsWidget.showSnackBar(
        title: AppStrings.title,
        message: AppStrings.messageAddItemFail,
      );
      return;
    }

    await _box.add(item);
    items.add(item);
    shoppingCartCount();

    UtilsWidget.showSnackBar(
      title: AppStrings.title,
      message: AppStrings.messageAddItem,
    );
  }
}
