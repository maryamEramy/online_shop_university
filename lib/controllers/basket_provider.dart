import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

// CartProvider.dart
class BasketProvider with ChangeNotifier {
  Box? _basketBox;
  List<dynamic> _basket = [];

  List<dynamic> get cart => _basket;

  set cart(List<dynamic> newCart){
    _basket = newCart;
    notifyListeners();
  }

  Future<void> setUserId(String userId) async {
    if(Hive.isBoxOpen('cart_box_$userId')){
      _basketBox = Hive.box('cart_box_$userId');
    } else {
      _basketBox = await Hive.openBox('cart_box_$userId');
    }
    getBasket();
  }



  Future<void> addBasket(Map<String, dynamic> newBasketItem) async {

    if (_basketBox == null) {
      throw Exception("Basket box not initialized. Call setUserId first.");
    }

    if (newBasketItem['price'] is String) {
      newBasketItem['price'] = double.tryParse(newBasketItem['price']) ?? 0.0;
    }


    final existingItems = _basketBox!.values.where((item) =>
    item['id'] == newBasketItem['id']).toList();

    if (existingItems.isNotEmpty) {
      // افزایش تعداد اگر محصول وجود دارد
      final existingItem = existingItems.first;
      final key = _basketBox!.keyAt(_basketBox!.values.toList().indexOf(existingItem));
      existingItem['qty'] = (existingItem['qty'] as int) + 1;
      await _basketBox!.put(key, existingItem);
    } else {
      await _basketBox!.add(newBasketItem);
    }
    getBasket();
  }

  getBasket(){
    if (_basketBox == null || !_basketBox!.isOpen) return;
    final basketData = _basketBox!.keys.map((key){
      final item = _basketBox!.get(key);
      return {
        "key": key,
        "id": item['id'],
        "category": item['category'],
        "name": item['name'],
        "imageUrl": item['imageUrl'],
        "price": item['price'],
        "sizes": item['sizes'],
        "qty": item['qty'],
      };
    }).toList();
    _basket = basketData.reversed.toList();
    notifyListeners();
  }

  Future<void> deleteBasketItem(int key) async {
    if (_basketBox == null) return;
    await _basketBox!.delete(key);
    getBasket();
  }

  void incrementQty(int key) {
    if (_basketBox == null) return;
    final item = _basketBox!.get(key);
    if (item != null) {
      item['qty'] = (item['qty'] as int) + 1;
      _basketBox!.put(key, item);
      getBasket();
    }
  }

  void decrementQty(int key) {
    if (_basketBox == null) return;
    final item = _basketBox!.get(key);
    if (item != null && item['qty'] > 1) {
      item['qty'] = (item['qty'] as int) - 1;
      _basketBox!.put(key, item);
      getBasket();
    }
  }

  double get totalPrice {
    double total = 0;
    if (_basketBox != null) {
      for (var key in _basketBox!.keys) {
        final item = _basketBox!.get(key);
        if (item != null) {
          final rawPrice = item['price'];
          final price = rawPrice is String
              ? double.tryParse(rawPrice) ?? 0.0
              : (rawPrice as num).toDouble();
          final qty = (item['qty'] as num).toInt();
          total += price * qty;
        }
      }
    }
    return total;
  }

  double productTotalPrice(String productId) {
    if (_basketBox == null) return 0.0;

    final item = _basketBox!.values.firstWhere(
          (element) => element['id'] == productId,
      orElse: () =>  <String, dynamic>{
        "id": "",
        "name": "",
        "category": "",
        "imageUrl": "",
        "price": 0.0,
        "qty": 0,
      },
    );

    if (item == null) return 0.0;

    final rawPrice = item['price'];
    final price = rawPrice is String
        ? double.tryParse(rawPrice) ?? 0.0
        : (rawPrice as num).toDouble();
    final qty = (item['qty'] as num).toInt();

    return price * qty;
  }





}
