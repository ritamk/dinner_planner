import 'package:dinner_planner/models/food.dart';
import 'package:dinner_planner/services/database.dart';
import 'package:flutter/cupertino.dart';

class FoodListProvider with ChangeNotifier {
  static List<Food> fullFood = [];
  List<Food> _food = [];
  List<Food> _searchedFood = [];

  bool _isOpen = false;

  void initFood(List<Food> food) {
    _food = food;
  }

  void addFood(List<Food>? food) {
    if (food != null) {
      _food.addAll(food);
    }
  }

  void openClose() {
    _isOpen = !_isOpen;
    notifyListeners();
    if (fullFood.isEmpty) {
      DatabaseService().fullFoodList.then((value) => fullFood = value);
    }
  }

  void searchFood(String word) {
    _searchedFood = fullFood;
    _searchedFood
        .retainWhere((element) => element.name.toLowerCase().contains(word));
    notifyListeners();
  }

  void searchClear() {
    _searchedFood.clear();
  }

  List<Food> get getFoodList => _food;
  List<Food> get getSearchedFoodList => _searchedFood;
  bool get isSearching => _isOpen;
}
