import 'package:flutter/cupertino.dart';
import '../models/sneakers_model.dart';
import '../services/product_helper.dart';

class ProductNotifier extends ChangeNotifier {
  late Future<ProductInfo> product;

  /// ***********************Search**************************
  String _searchQuery = "";
  double _minPrice = 0;
  double _maxPrice = 1000;

  String get searchQuery => _searchQuery;
  double get minPrice => _minPrice;
  double get maxPrice => _maxPrice;

  void setSearchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  void setPriceRange(double min, double max) {
    _minPrice = min;
    _maxPrice = max;
    notifyListeners();
  }

  List<ProductInfo> get filteredProducts {
    if (_allProducts.isEmpty) {
      return [];
    }
    return _allProducts.where((product) {
      final matchesQuery =
          product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              product.category.toLowerCase().contains(_searchQuery.toLowerCase());
      final doublePrice = double.tryParse(product.price) ?? 0.0;

      final withinPrice = doublePrice >= _minPrice && doublePrice <= _maxPrice;

      return matchesQuery && withinPrice;
    }).toList();
  }

  /// *********************************************************

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
