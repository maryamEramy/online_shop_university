import 'package:flutter/cupertino.dart';

class ProductNotifier extends ChangeNotifier {
  int _activepage = 0;
  List<dynamic> _shoeSizes = [];

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
        _shoeSizes[index]['isSelected'] =! _shoeSizes[index]['isSelected'];
      }
    }
  }
}