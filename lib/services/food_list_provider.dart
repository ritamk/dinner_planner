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
  }

  void searchFood(String word) async {
    if (fullFood.isEmpty) {
      await DatabaseService().fullFoodList.then((value) => fullFood = value);
    }
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
