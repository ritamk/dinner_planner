import 'package:flutter/cupertino.dart';

class FilterListProvider with ChangeNotifier {
  final List<String> _selectedFilter = [
    "All",
    "Starters",
    "Soups",
    "Salads",
    "Sandwiches",
  ];

  int _num = 0;

  PageController _pageController = PageController();

  String get filteredString => _selectedFilter[_num];

  List<String> get filterList => _selectedFilter;

  int get filterIndex => _num;

  void filterChange(int num) {
    _num = num;
    _pageController.animateToPage(num,
        duration: Duration(milliseconds: 100), curve: Curves.easeIn);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
