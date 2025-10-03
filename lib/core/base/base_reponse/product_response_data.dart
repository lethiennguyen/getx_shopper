class ProductData {
  int? id;
  String? name;
  int? price;
  int? quantity;
  String? cover;

  ProductData({this.id, this.name, this.price, this.quantity, this.cover});
  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      cover: json['cover'],
    );
  }
}
