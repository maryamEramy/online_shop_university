
import 'dart:convert';

List<ProductInfo> sneakersFromJson(String str) => List<ProductInfo>.from(json.decode(str).map((x) => ProductInfo.fromJson(x)));

class ProductInfo {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final String price;
  final String description;

  ProductInfo({
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


//
// import 'dart:convert';
//
// List<ProductInfo> sneakersFromJson(String str) => List<ProductInfo>.from(json.decode(str).map((x) => ProductInfo.fromJson(x)));
//
// class ProductInfo {
//   final String id;
//   final String name;
//   final String category;
//   final String title;
//   final String description;
//   final String imageUrl;
//   final String oldPrice;
//   final String price;
//   final List<dynamic> sizes;
//
//   ProductInfo({
//     required this.id,
//     required this.name,
//     required this.category,
//     required this.title,
//     required this.description,
//     required this.imageUrl,
//     required this.oldPrice,
//     required this.price,
//     required this.sizes,
//   });
//
//   factory ProductInfo.fromJson(Map<String, dynamic> json) => ProductInfo(
//     id: json["id"],
//     name: json["name"],
//     category: json["category"],
//     title: json["title"],
//     description: json["description"],
//     imageUrl: json["imageUrl"],
//     oldPrice: json["oldPrice"],
//     price: json["price"],
//     sizes: List<dynamic>.from(json["sizes"].map((x) => x)),
//   );
//
// }
