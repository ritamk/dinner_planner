import 'package:flutter/cupertino.dart';

class FilterListProvider with ChangeNotifier {
  final List<String> _selectedFilter = [
    "All",
    "Starters",
    "Soups",
    "Salads",
  ];

  int _num = 0;

  String get filteredString => _selectedFilter[_num];

  List<String> get filterList => _selectedFilter;

  int get filterIndex => _num;

  void filterChange(int num) {
    _num = num;
    notifyListeners();
  }
}
