import 'package:flutter/cupertino.dart';
import '../models/sneakers_model.dart';
import '../services/helper.dart';

class ProductNotifier extends ChangeNotifier {

  int _activepage = 0;
  List<ProductInfo> _allProducts = [];
  ProductInfo? _selectedProduct;

  int get activepage => _activepage;
  List<ProductInfo> get allProducts => _allProducts;
  ProductInfo? get selectedProduct => _selectedProduct;

  set activePage(int newIndex) {
    _activepage = newIndex;
    notifyListeners();
  }


  Future<List<ProductInfo>> getProducts(String category) async {
    return await Helper().getProductsByCategory(category);
  }

  /// گرفتن محصول خاص و ذخیره در state
  // Future<void> getProduct(String category, String id) async {
  //   _selectedProduct = await Helper().getProductById(category, id);
  //   notifyListeners(); // اینجا لازمه چون selectedProduct تغییر می‌کنه
  // }
  Future<ProductInfo> getProduct(String category, String id) async {
    product = Helper().getProductById(category, id);
    // notifyListeners();
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


  late Future<ProductInfo> product;







  // Future<List<ProductInfo>> getProducts(String category) async {
  //   final products = await Helper().getProductsByCategory(category);
  //   // notifyListeners() را حذف کنید چون FutureBuilder خودش مدیریت می‌کند
  //   return products;
  // }
  // Future<List<ProductInfo>> getProducts(String category) {
  //   products = Helper().getProductsByCategory(category);
  //   notifyListeners();
  //   return products;
  // }



  // Future<ProductInfo> getProduct(String category, String id) async {
  //   return await Helper().getProductById(category, id);
  // }
  // void getProduct(String category, String id) {
  //   product = Helper().getProductById(category, id);
  //   notifyListeners();
  // }

  // late Future<List<ProductInfo>> products;






}
