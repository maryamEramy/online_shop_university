import 'package:flutter/cupertino.dart';
import '../models/sneakers_model.dart';
import '../services/helper.dart';

class ProductNotifier extends ChangeNotifier {
  int _activepage = 0;
  List<dynamic> _shoeSizes = [];
  List<String> _sizes = [];

  int get activepage => _activepage;

  set activePage(int newIndex) {
    _activepage = newIndex;
    notifyListeners();
  }

  List<dynamic> get shoeSizes => _shoeSizes;

  set shoeSizes(List<dynamic> newSizes) {
    _shoeSizes = newSizes;
    notifyListeners();
  }

  void toggleCheck(int index) {
    for (int i = 0; i < _shoeSizes.length; i++) {
      if (i == index) {
        _shoeSizes[i]['isSelected'] = !_shoeSizes[i]['isSelected'];
      }
    }
    notifyListeners();
  }

  List<String> get sizes => _sizes;

  set sizes(List<String> newSizes) {
    _sizes = newSizes;
    notifyListeners();
  }

  late Future<List<ProductInfo>> products;
  late Future<ProductInfo> product;

  Future<List<ProductInfo>> getProducts(String category) {
    products = Helper().getProductsByCategory(category);
    notifyListeners();
    return products;
  }

  // Future<List<ProductInfo>> getProduct(String category, String id) {
  //   product = Helper().getProductById(category, id);
  //   notifyListeners();
  //   return product;
  // }

  // void getProducts(String category) {
  //   products = Helper().getProductsByCategory(category);
  //   notifyListeners();
  // }

  void getProduct(String category, String id) {
    product = Helper().getProductById(category, id);
    notifyListeners();
  }


  // یک لیست داخلی برای نگهداری همه محصولات
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
