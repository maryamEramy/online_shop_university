import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/sneakers_model.dart';  // اینو اضافه کن تا ProductInfo رو داشته باشی


class FavoritesNotifier extends ChangeNotifier {
  Box? _favBox;
  List<dynamic> _ids = [];
  List<dynamic> _favorites = [];
  List<dynamic> _fav = [];

  List<dynamic> get ids => _ids;
  List<dynamic> get favorites => _favorites;
  List<dynamic> get fav => _fav;

  Future<void> setUserId(String userId) async {
    if(Hive.isBoxOpen('fav_box_$userId')){
      _favBox = Hive.box('fav_box_$userId');
    } else {
      _favBox = await Hive.openBox('fav_box_$userId');
    }
    getAllData();
    getFavorites();
  }

  Future<void> deleteFav(int key) async {
    if (_favBox == null) return;
    await _favBox!.delete(key);
    await getFavorites();
    getAllData();
  }

  Future<void> createFav(Map<String, dynamic> addFav) async {
    if (_favBox == null) return;
    await _favBox!.add(addFav);
    await getFavorites();
    getAllData();
  }

  getAllData(){
    if (_favBox == null || !_favBox!.isOpen) return;
    final favData = _favBox!.keys.map((key) {
      final item = _favBox!.get(key);
      return ProductInfo(
        key: key,
        id: item['id'].toString(),
        name: item['name'],
        category: item['category'],
        price: item['price'],
        imageUrl: item['imageUrl'],
        description: "",
      );
    }).toList();
    _fav = favData.reversed.toList();
    _ids = _fav.map((item) => item.id).toList();
    notifyListeners();
  }

  getFavorites() {
    if (_favBox == null || !_favBox!.isOpen) return;
    final favData = _favBox!.keys.map((key) {
      final item = _favBox!.get(key);
      return {
        "key": key,
        "id": item['id'],
      };
    }).toList();

    _favorites = favData.toList();
    _ids = _favorites.map((item) => item['id']).toList();
    notifyListeners();
  }
}
