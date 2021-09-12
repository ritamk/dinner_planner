import 'package:dinner_planner/models/food.dart';
import 'package:dinner_planner/services/database.dart';
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
    DatabaseService().fullFoodList.then((value) {
      _searchedFood = value;
      _food = value;
    });
    _searchedFood
        .retainWhere((element) => element.name.toLowerCase().contains(word));
    notifyListeners();
  }

  void searchClear() {
    _searchedFood.clear();
  }

  List<Food> get getFoodList => _food;
  List<Food> get getSearchedFoodList => _searchedFood;
  bool get isOpen => _isOpen;
}
