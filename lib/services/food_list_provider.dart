import 'package:dinner_planner/models/food.dart';
import 'package:flutter/cupertino.dart';

class FoodListProvider with ChangeNotifier {
  List<Food> _food = [];
  List<Food> _searchedFood = [];

  bool _isOpen = false;

  void addFood(List<Food> food) {
    _food = food;
    // notifyListeners();
  }

  void openClose() {
    _isOpen = !_isOpen;
    notifyListeners();
  }

  void searchFood(String word) {
    _searchedFood = _food;
    _searchedFood
        .retainWhere((element) => element.name.toLowerCase().contains(word));
    notifyListeners();
  }

  void searchClear() {
    _searchedFood = _food;
    notifyListeners();
  }

  List<Food> get getFoodList => _food;
  List<Food> get getSearchedFoodList => _searchedFood;
  bool get isOpen => _isOpen;
}
