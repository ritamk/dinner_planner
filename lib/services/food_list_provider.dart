import 'package:dinner_planner/models/food.dart';
import 'package:flutter/cupertino.dart';

class FoodListProvider with ChangeNotifier {
  List<Food> _food = [];
  List<Food> _searchedFood = [];

  bool _isOpen = false;

  void addFood(List<Food> food) {
    _food = food;
    notifyListeners();
  }

  void searchFood(String word) {
    _searchedFood = _food;
    _searchedFood.retainWhere((element) => element.name.contains(word));
    notifyListeners();
  }

  void openClose() {
    _isOpen = !_isOpen;
    notifyListeners();
  }

  List<Food> get getFoodList => _food;
  List<Food> get getSearchedFoodList => _searchedFood;
  bool get isOpen => _isOpen;
}
