
import 'dart:convert';

List<Sneakers> sneakersFromJson(String str) => List<Sneakers>.from(json.decode(str).map((x) => Sneakers.fromJson(x)));

class Sneakers {
  final String id;
  final String name;
  final String category;
  final String title;
  final String description;
  final String imageUrl;
  final String oldPrice;
  final String price;
  final List<dynamic> sizes;

  Sneakers({
    required this.id,
    required this.name,
    required this.category,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.oldPrice,
    required this.price,
    required this.sizes,
  });

  factory Sneakers.fromJson(Map<String, dynamic> json) => Sneakers(
    id: json["id"],
    name: json["name"],
    category: json["category"],
    title: json["title"],
    description: json["description"],
    imageUrl: json["imageUrl"],
    oldPrice: json["oldPrice"],
    price: json["price"],
    sizes: List<dynamic>.from(json["sizes"].map((x) => x)),
  );

}
