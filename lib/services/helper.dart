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







// import 'dart:convert';
//
// import 'package:flutter/services.dart' as the_bundle;
// import 'package:http/http.dart' as http;
// import 'package:uni_online_shop/models/sneakers_model.dart';
// class Helper{
//
//   final String baseUrl = "https://dummyjson.com/products/category";
//
//
//   Future<List<ProductInfo>> getBeauty() async {
//     final response = await http.get(Uri.parse("$baseUrl/beauty"));
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return List<ProductInfo>.from(
//         data["products"].map((x) => ProductInfo.fromJson(x)),
//       );
//     } else {
//       throw Exception("Failed to load beauty products");
//     }
//   }
//
//   Future<ProductInfo> getBeautyById(String id) async {
//     final products = await getBeauty();
//     return products.firstWhere((p) => p.id == id);
//   }
//
//
//
//
//   //list*************
//
//   Future<List<ProductInfo>> getMaleSneaker() async {
//     final data = await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");
//     final maleList = sneakersFromJson(data);
//
//     return maleList;
//   }
//
//
//   Future<List<ProductInfo>> getFemaleSneaker() async {
//     final data = await the_bundle.rootBundle.loadString("assets/json/female_shoes.json");
//     final femaleList = sneakersFromJson(data);
//
//     return femaleList;
//   }
//
//
//   Future<List<ProductInfo>> getKidsSneaker() async {
//     final data = await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");
//     final kidsList = sneakersFromJson(data);
//
//     return kidsList;
//   }
//
//
// //single************
//
//   Future<ProductInfo> getMaleSneakerById(String id) async {
//     final data = await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");
//     final maleList = sneakersFromJson(data);
//     final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);
//
//     return sneaker;
//   }
//
//   Future<ProductInfo> getFemaleSneakerById(String id) async {
//     final data = await the_bundle.rootBundle.loadString("assets/json/female_shoes.json");
//     final femaleList = sneakersFromJson(data);
//     final sneaker = femaleList.firstWhere((sneaker) => sneaker.id == id);
//
//
//     return sneaker;
//   }
//
//   Future<ProductInfo> getKidsSneakerById(String id) async {
//     final data = await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");
//     final kidsList = sneakersFromJson(data);
//     final sneaker = kidsList.firstWhere((sneaker) => sneaker.id == id);
//
//
//     return sneaker;
//   }
//
// }