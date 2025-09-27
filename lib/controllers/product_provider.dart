import 'package:flutter/cupertino.dart';
import '../models/sneakers_model.dart';
import '../services/product_helper.dart';

class ProductNotifier extends ChangeNotifier {
  late Future<ProductInfo> product;

  int _activePage = 0;
  List<ProductInfo> _allProducts = [];
  ProductInfo? _selectedProduct;

  int get activepage => _activePage;
  List<ProductInfo> get allProducts => _allProducts;
  ProductInfo? get selectedProduct => _selectedProduct;

  set activePage(int newIndex) {
    _activePage = newIndex;
    notifyListeners();
  }

  Future<List<ProductInfo>> getProducts(String category) async {
    return await Helper().getProductsByCategory(category);
  }

  Future<ProductInfo> getProduct(String category, String id) async {
    product = Helper().getProductById(category, id);
    return await product;
  }

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
