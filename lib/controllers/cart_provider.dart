import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';

class CartProvider with ChangeNotifier{
  final _cartBox = Hive.box('cart_box');
  List<dynamic> _cart = [];

  List<dynamic> get cart => _cart;
  set cart(List<dynamic> newCart){
    _cart = newCart;
    notifyListeners();
  }

  Future<void> addCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart);
    getCart(); // آپدیت لیست بعد از اضافه شدن
    notifyListeners();
  }

  getCart(){
    final cartDate = _cartBox.keys.map((key){
      final item = _cartBox.get(key);
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
    _cart = cartDate.reversed.toList();
  }

  Future<void>deleteCart(int key) async {
    await _cartBox.delete(key);
  }


  int _counter =0;
  int get counter => _counter;

  void increment(){
    _counter++;
    notifyListeners();
  }

  void decrement(){
    if(_counter >= 1){
      _counter--;
      notifyListeners();
    }
  }
}