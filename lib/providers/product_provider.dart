import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier{
  String _filter = 'date_added';

  String get getFilter => _filter;

  void changeFilterMostRecent (){
    _filter = 'date_added';
    notifyListeners();
  }

  void changeFilterAlphabetically (){
    _filter = 'prod_name';
    notifyListeners();
  }
}