import 'dart:convert';

List<ProductInfo> sneakersFromJson(String str) => List<ProductInfo>.from(
  json.decode(str).map((x) => ProductInfo.fromJson(x)),
);

class ProductInfo {
  int? key;
  int? qty;
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final String price;
  final String description;

  ProductInfo({
    this.key,
    this.qty,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.category,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "category": category,
      "imageUrl": imageUrl,
      "price": price,
      "description": description,
      "qty": qty ?? 0,
    };
  }

  factory ProductInfo.fromMap(Map<dynamic, dynamic> map, {int? key}) {
    return ProductInfo(
      key: key,
      id: map["id"],
      name: map["name"],
      category: map["category"],
      imageUrl: map["imageUrl"],
      price: map["price"],
      description: map["description"],
      qty: map["qty"],
    );
  }

  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    return ProductInfo(
      id: json['id'].toString(),
      name: json['title'],
      imageUrl: json['thumbnail'],
      price: (json['price'] as num).toString(),
      category: json['category'],
      description: json['description'],
      qty: json["qty"] ?? 1,
    );
  }
}
