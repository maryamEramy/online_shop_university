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
}
