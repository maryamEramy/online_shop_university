import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

class BasketProvider with ChangeNotifier {
  Box? _basketBox;
  List<dynamic> _basket = [];

  List<dynamic> get cart => _basket;

  Future<void> setUserId(String userId) async {
    if (Hive.isBoxOpen('cart_box_$userId')) {
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

    final String itemId = newBasketItem['id'];

    final price =
        newBasketItem['price'] is String
            ? double.tryParse(newBasketItem['price']) ?? 0.0
            : (newBasketItem['price'] as num).toDouble();
    newBasketItem['price'] = price;

    int? existingKey;
    Map<String, dynamic>? existingItem;

    // search by id
    for (var key in _basketBox!.keys) {
      final item = _basketBox!.get(key);
      if (item != null && item['id'] == itemId) {
        existingKey = key;
        existingItem = Map<String, dynamic>.from(item);
        break;
      }
    }

    if (existingItem != null && existingKey != null) {
      existingItem['qty'] = (existingItem['qty'] as int) + 1;
      await _basketBox!.put(existingKey, existingItem);
    } else {
      await _basketBox!.add(newBasketItem);
    }
    getBasket();
  }

  //get product data from basket
  Map<String, dynamic> getProductFromCart(String productId) {
    if (_basketBox == null || !_basketBox!.isOpen) {
      return {
        "id": productId,
        "name": "",
        "category": "",
        "imageUrl": "",
        "price": 0.0,
        "qty": 0,
        "key": null,
      };
    }

    final item = _basket.firstWhere(
      (element) => element['id'] == productId,
      orElse:
          () => {
            "id": productId,
            "name": "",
            "category": "",
            "imageUrl": "",
            "price": 0.0,
            "qty": 0,
            "key": null,
          },
    );

    return item;
  }

  getBasket() {
    if (_basketBox == null || !_basketBox!.isOpen) return;

    final List<dynamic> basketData = [];

    for (final key in _basketBox!.keys) {
      final item = _basketBox!.get(key);
      if (item != null) {
        basketData.add({
          "key": key,
          "id": item['id'].toString(),
          "category": item['category'] as String,
          "name": item['name'] as String,
          "imageUrl": item['imageUrl'] as String,
          "price": item['price'],
          "sizes": item['sizes'],
          "qty": (item['qty'] as num).toInt(),
        });
      }
    }

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
    final item = Map<String, dynamic>.from(_basketBox!.get(key));
    if (item['qty'] != null) {
      item['qty'] = (item['qty'] as int) + 1;
      _basketBox!.put(key, item);
      getBasket();
    }
  }

  void decrementQty(int key) {
    if (_basketBox == null) return;
    final item = Map<String, dynamic>.from(_basketBox!.get(key));
    if (item['qty'] != null && item['qty'] > 1) {
      item['qty'] = (item['qty'] as int) - 1;
      _basketBox!.put(key, item);
      getBasket();
    } else if (item['qty'] == 1) {
      deleteBasketItem(key);
    }
  }

  double get totalPrice {
    double total = 0;
    if (_basketBox != null && _basketBox!.isOpen) {
      for (var item in _basketBox!.values) {
        if (item != null) {
          final dynamic rawPrice = item['price'];
          final price =
              rawPrice is num
                  ? rawPrice.toDouble()
                  : double.tryParse(rawPrice.toString()) ?? 0.0;
          final qty = (item['qty'] as num).toInt();
          total += price * qty;
        }
      }
    }
    return total;
  }

  double productTotalPrice(String productId) {
    final item = getProductFromCart(productId);

    final dynamic rawPrice = item['price'];
    final price =
        rawPrice is num
            ? rawPrice.toDouble()
            : double.tryParse(rawPrice.toString()) ?? 0.0;
    final qty = (item['qty'] as num).toInt();

    return price * qty;
  }
}
