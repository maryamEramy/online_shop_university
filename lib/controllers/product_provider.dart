import 'package:flutter/cupertino.dart';
import '../models/sneakers_model.dart';
import '../services/helper.dart';

class ProductNotifier extends ChangeNotifier {
  int _activepage = 0;

  int get activepage => _activepage;

  set activePage(int newIndex) {
    _activepage = newIndex;
    notifyListeners();
  }

  late Future<List<ProductInfo>> products;
  late Future<ProductInfo> product;

  Future<List<ProductInfo>> getProducts(String category) {
    products = Helper().getProductsByCategory(category);
    notifyListeners();
    return products;
  }

  void getProduct(String category, String id) {
    product = Helper().getProductById(category, id);
    notifyListeners();
  }


  List<ProductInfo> _allProducts = [];
  List<ProductInfo> get allProducts => _allProducts;
  Future<void> fetchAllProducts() async {
    final categories = [
      "mens-shoes",
      "beauty",
      "fragrances",
      "furniture",
      "groceries",
      "laptops",
      "mens-shirts",
      "mens-watches",
      "home-decoration",
      "kitchen-accessories",
      "smartphones",
      "motorcycle",
      "skin-care",
    ];

    List<ProductInfo> tempList = [];

    for (String category in categories) {
      List<ProductInfo> productsByCategory = await Helper()
          .getProductsByCategory(category);
      tempList.addAll(productsByCategory);
    }

    _allProducts = tempList;
    notifyListeners();
  }
}
