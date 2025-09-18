import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

// CartProvider.dart
class CartProvider with ChangeNotifier {
  Box? _cartBox;
  List<dynamic> _cart = [];

  List<dynamic> get cart => _cart;

  set cart(List<dynamic> newCart){
    _cart = newCart;
    notifyListeners();
  }

  Future<void> setUserId(String userId) async {
    if(Hive.isBoxOpen('cart_box_$userId')){
      _cartBox = Hive.box('cart_box_$userId');
    } else {
      _cartBox = await Hive.openBox('cart_box_$userId');
    }
    getCart();
  }



  Future<void> addCart(Map<String, dynamic> newCart) async {

    if (_cartBox == null) {
      throw Exception("Cart box not initialized. Call setUserId first.");
    }

    final existingItems = _cartBox!.values.where((item) =>
    item['id'] == newCart['id']).toList();

    if (existingItems.isNotEmpty) {
      // افزایش تعداد اگر محصول وجود دارد
      final existingItem = existingItems.first;
      final key = _cartBox!.keyAt(_cartBox!.values.toList().indexOf(existingItem));
      existingItem['qty'] = (existingItem['qty'] as int) + 1;
      await _cartBox!.put(key, existingItem);
    } else {
      // اضافه کردن محصول جدید
      await _cartBox!.add(newCart);
    }
    // if (_cartBox == null) return;
    // await _cartBox!.add(newCart);
    getCart();
  }

  getCart(){
    if (_cartBox == null || !_cartBox!.isOpen) return;
    final cartData = _cartBox!.keys.map((key){
      final item = _cartBox!.get(key);
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
    _cart = cartData.reversed.toList();
    notifyListeners();
  }

  Future<void> deleteCart(int key) async {
    if (_cartBox == null) return;
    await _cartBox!.delete(key);
    getCart();
  }

  void incrementQty(int key) {
    if (_cartBox == null) return;
    final item = _cartBox!.get(key);
    if (item != null) {
      item['qty'] = (item['qty'] as int) + 1;
      _cartBox!.put(key, item);
      getCart();
    }
  }

  void decrementQty(int key) {
    if (_cartBox == null) return;
    final item = _cartBox!.get(key);
    if (item != null && item['qty'] > 1) {
      item['qty'] = (item['qty'] as int) - 1;
      _cartBox!.put(key, item);
      getCart();
    }
  }
}
