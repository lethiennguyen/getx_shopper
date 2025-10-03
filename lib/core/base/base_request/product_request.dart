class ProductRequest {
  String? name;
  int? price;
  int? quantity;
  String? cover;

  ProductRequest({this.name, this.price, this.quantity, this.cover});
  factory ProductRequest.fromJson(Map<String, dynamic> json) {
    return ProductRequest(
      name: json['name'] ?? '',
      price: json['price'] ?? '',
      quantity: json['quantity'] ?? '',
      cover: json['cover'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {'name': name, 'price': price, 'quantity': quantity, 'cover': cover};
  }
}
