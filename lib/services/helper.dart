import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uni_online_shop/models/sneakers_model.dart';

class Helper {
  final String baseUrl = "https://dummyjson.com/products/category";

  Future<List<ProductInfo>> getProductsByCategory(String category) async {
    final response = await http.get(Uri.parse("$baseUrl/$category"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<ProductInfo>.from(
        data["products"].map((x) => ProductInfo.fromJson(x)),
      );
    } else {
      throw Exception("Failed to load products for $category");
    }
  }

  Future<ProductInfo> getProductById(String category, String id) async {
    final products = await getProductsByCategory(category);
    return products.firstWhere((p) => p.id == id);
  }
}
