import 'package:flutter/cupertino.dart';

import '../models/sneakers_model.dart';
import '../services/helper.dart';

class ProductNotifier extends ChangeNotifier {
  int _activepage = 0;
  List<dynamic> _shoeSizes = [];
  List<String> _sizes = [];

  int get activepage => _activepage;

  set activePage(int newIndex){
    _activepage = newIndex;
    notifyListeners();
  }

  List<dynamic> get shoeSizes => _shoeSizes;

  set shoeSizes(List<dynamic> newSizes) {
    _shoeSizes = newSizes;
    notifyListeners();
  }

  void toggleCheck(int index){
    for(int i = 0 ; i < _shoeSizes.length; i++){
      if( i == index){
        _shoeSizes[i]['isSelected'] = !_shoeSizes[i]['isSelected'];
      }
    }
    notifyListeners();
  }

  List<String> get sizes => _sizes;

  set sizes(List<String> newSizes){
    _sizes = newSizes;
    notifyListeners();
  }

  late Future<List<Sneakers>> male;
  late Future<List<Sneakers>> female;
  late Future<List<Sneakers>> kids;
  late Future<Sneakers> sneakers;


  void getMale() {
    male = Helper().getMaleSneaker();
  }

  void getFemale() {
    female = Helper().getFemaleSneaker();
  }

  void getKids() {
    kids = Helper().getKidsSneaker();
  }



  void getShoes(String category , String id) {
    if (category == "men's Running") {
      sneakers = Helper().getMaleSneakerById(id);
    } else if (category == "female's Running") {
      sneakers = Helper().getFemaleSneakerById(id);
    } else {
      sneakers = Helper().getKidsSneakerById(id);
    }
  }

}