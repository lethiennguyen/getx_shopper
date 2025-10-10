import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:getx_curd/core/base/base_controller/base_controller.dart';
import 'package:hive/hive.dart';

import '../../../core/values/key.dart';
import '../model/hive_shopping_cart.dart';

class ShoppingCartController extends BaseGetxController {
  late final Box<CartItem> box;

  final RxBool checkAll = false.obs;
  final RxInt sumItem = 0.obs;
  final RxBool deletedSomething = false.obs;
  @override
  void onInit() {
    super.onInit();
    box = Hive.box<CartItem>(HiveBoxNames.cartbox);
    checkAll.value = false;
    sumItem.value = 0;
  }

  List<CartItem> get items => box.values.toList();

  void checkALL() {
    if (box.values.toList().isEmpty) {
      checkAll.value = false;
    }
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
    await box.delete(key);
    deletedSomething.value = true;
    checkALL();
    sum();
  }

  /// tính tổng tiền
  void sum() {
    sumItem.value = 0;
    for (var item in items) {
      if (item.checked == true) {
        sumItem.value += item.price * item.quantity;
      }
    }
  }

  /// tăng giảm số lượng
  void quantityChange(int id, bool isIncrease) {
    final key = findKeyByProductId(id);
    if (key == null) return;

    final item = box.get(key)!;
    if (isIncrease) {
      item.quantity++;
    } else {
      if (item.quantity > 1) {
        item.quantity--;
      }
    }
    box.put(key, item);
    sum();
  }

  void selectById(int id, bool value) {
    final key = findKeyByProductId(id);
    if (key == null) return;
    final item = box.get(key)!;
    item.checked = value;
    box.put(key, item);
    sum();
  }

  /// chọn tất cả
  void selectAll(bool value) {
    checkAll.value = value;
    for (var key in box.keys) {
      final item = box.get(key)!;
      item.checked = value;
      box.put(key, item);
    }
    sum();
  }

  /// xóa theo từng mục đã chọn
  Future<void> removeSelected() async {
    final keysToRemove = box.keys
        .where((k) => box.get(k)!.checked ?? false)
        .toList();
    for (var key in keysToRemove) {
      await box.delete(key);
    }
    deletedSomething.value = true;
    checkALL();
    sum();
  }
}
