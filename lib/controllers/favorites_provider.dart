import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/sneakers_model.dart';

class FavoritesProvider extends ChangeNotifier {
  Box? _favBox;
  List<dynamic> _ids = [];
  List<dynamic> _favorites =
      []; // that list contains tow parameter {"key": key, "id": item['id']}
  List<ProductInfo> _fav = []; // that list contain ProductInfo

  List<dynamic> get ids => _ids;
  List<dynamic> get favorites => _favorites;
  List<ProductInfo> get fav => _fav;

  Future<void> setUserId(String userId) async {
    if (Hive.isBoxOpen('fav_box_$userId')) {
      _favBox = Hive.box('fav_box_$userId');
    } else {
      _favBox = await Hive.openBox('fav_box_$userId');
    }
    await _updateAllFavorites();
  }

  // delete by productKey
  Future<void> deleteFav(int key) async {
    if (_favBox == null) return;
    await _favBox!.delete(key);
    await _updateAllFavorites();
  }

  // delete by productId
  Future<void> deleteFavByProductId(String productId) async {
    if (_favBox == null) return;
    final itemToRemove = _favorites.firstWhere(
      (item) => item['id'] == productId,
      orElse: () => null,
    );

    if (itemToRemove != null && itemToRemove['key'] != null) {
      await _favBox!.delete(itemToRemove['key']);
      await _updateAllFavorites();
    }
  }

  Future<void> createFav(Map<String, dynamic> addFav) async {
    if (_favBox == null) return;

    if (addFav['price'] is String) {
      addFav['price'] = double.tryParse(addFav['price']) ?? 0.0;
    }
    await _favBox!.add(addFav);
    await _updateAllFavorites();
  }

  Future<void> _updateAllFavorites() async {
    if (_favBox == null || !_favBox!.isOpen) return;

    final List<dynamic> allKeys = _favBox!.keys.toList();
    final List<Map<String, dynamic>> favItems = []; //a list for ids and favs
    final List<ProductInfo> favProductsList = [];

    for (final key in allKeys) {
      final item = _favBox!.get(key);
      if (item != null) {
        //price to String
        final dynamic rawPrice = item['price'];
        final String safePrice =
            rawPrice is num
                ? rawPrice.toStringAsFixed(2)
                : (double.tryParse(rawPrice.toString()) ?? 0.0).toStringAsFixed(
                  2,
                );

        favItems.add({"key": key, "id": item['id'].toString()});

        favProductsList.add(
          ProductInfo(
            key: key,
            id: item['id'].toString(),
            name: item['name'] as String,
            category: item['category'] as String,
            price: safePrice,
            imageUrl: item['imageUrl'] as String,
            description: item['description'] ?? "",
          ),
        );
      }
    }

    _favorites = favItems.reversed.toList();
    _fav = favProductsList.reversed.toList();
    _ids = _favorites.map((item) => item['id']).toList();

    notifyListeners();
  }

  getFavorites() => _updateAllFavorites();
  getAllData() => _updateAllFavorites();
}
