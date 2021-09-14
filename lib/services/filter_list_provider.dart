import 'package:flutter/cupertino.dart';

class FilterListProvider with ChangeNotifier {
  final List<String> _selectedFilter = [
    "All",
    "Starters",
    "Soups",
    "Salads",
    "Sandwiches",
  ];

  int _selectedIndex = 0;

  PageController _pageController = PageController();

  String get filteredString => _selectedFilter[_selectedIndex];

  List<String> get filterList => _selectedFilter;

  int get filterIndex => _selectedIndex;

  void filterChange(int index) {
    _selectedIndex = index;
    _pageController.jumpToPage(index);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
