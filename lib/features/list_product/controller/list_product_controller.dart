import 'package:get/get.dart';
import 'package:getx_curd/core/base/base_controller/base_refesh_controller.dart';
import 'package:getx_curd/core/base/base_reponse/base_response_data.dart';
import 'package:getx_curd/core/base/base_request/base_request_model.dart';
import 'package:getx_curd/core/values/const.dart';
import 'package:intl/intl.dart';

import '../../../core/values/strings.dart';
import '../../../utils/show_popup.dart';
import '../repository/list_product_repository.dart';

class ListProductController extends BaseRefreshGetxController {
  late final ListProductRepository _listProduct = ListProductRepository(this);

  RxList<ProductData> listProduct = <ProductData>[].obs;
  final currencyFormatter = NumberFormat('#,##0', 'vi_VN');

  RxBool isLoadMore = true.obs;

  int pageIndex = 1;

  @override
  void onInit() {
    super.onInit();
    onRefresh();
  }

  @override
  Future<void> onRefresh() async {
    showLoading();
    pageIndex = AppConst.pageIndex1;
    isLoadMore.value = true;
    await _fetchData();
    refreshController.refreshCompleted();
    hideLoading();
  }

  @override
  Future<void> onLoadMore() async {
    pageIndex++;
    await _fetchData();
    refreshController.loadComplete();
  }

  Future<void> _fetchData() async {
    final request = BaseRequestListModel(page: pageIndex, pageSize: 10);
    final result = await _listProduct.getListProduct(request);
    if (result == null) {
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

  String formatPrice(num price) {
    String formatted = currencyFormatter.format(price);

    String onlyDigits = formatted.replaceAll(RegExp(r'\D'), '');

    if (onlyDigits.length > 9) {
      return '${formatted.substring(0, 9)}... VNĐ';
    }
    return '$formatted VNĐ';
  }
}
