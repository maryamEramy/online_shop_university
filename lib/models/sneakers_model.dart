import 'dart:convert';

List<ProductInfo> sneakersFromJson(String str) => List<ProductInfo>.from(
  json.decode(str).map((x) => ProductInfo.fromJson(x)),
);

class ProductInfo {
  int ? key;
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final String price;
  final String description;

  ProductInfo({
    this.key,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.category,
    required this.description,
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    return ProductInfo(
      id: json['id'].toString(),
      name: json['title'],
      imageUrl: json['thumbnail'],
      price: (json['price'] as num).toString(),
      category: json['category'],
      description: json['description'],
    );
  }
}
