import 'dart:ui';

class ShoppingCartOperationModel {
  String name;
  String price;
  String quantity;
  String cover;
  VoidCallback onIncrease;
  VoidCallback onReduce;

  ShoppingCartOperationModel(
    this.name,
    this.price,
    this.quantity,
    this.cover,
    this.onIncrease,
    this.onReduce,
  );
}
