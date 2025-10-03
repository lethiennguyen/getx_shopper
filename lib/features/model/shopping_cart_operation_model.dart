import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ShoppingCartOperationModel {
  String? name;
  int? price;
  int? totalPrice;
  int? quantity;
  String? cover;
  VoidCallback? onIncrease;
  VoidCallback? onReduce;
  ValueChanged onChange;
  bool? isCheckBox;

  ShoppingCartOperationModel({
    this.name,
    this.price,
    this.totalPrice,
    this.quantity,
    this.cover,
    this.onIncrease,
    this.onReduce,
    required this.onChange,
    this.isCheckBox = false,
  });
}
