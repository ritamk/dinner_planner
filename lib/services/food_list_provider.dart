import 'package:dinner_planner/models/food.dart';
import 'package:dinner_planner/services/database.dart';
import 'package:flutter/cupertino.dart';

class FoodListProvider with ChangeNotifier {
  List<Food> _food = [];
  List<Food> _searchedFood = [];

  bool _isOpen = false;
  bool _searchLoading = false;
  bool _loadMore = false;

  void initFood(List<Food> food) {
    _food = food;
  }

  void addFood(List<Food>? food) {
    if (food != null) {
      _food.addAll(food);
    }
  }

  // List<Food> addMoreFood() {
  //   Future<List<Food>> food = DatabaseService().moreFoodList;
  //   List<Food> list = [];
  //   food.then((value) {
  //     list = value;
  //   });
  //   return list;
  // }

  void openClose() {
    _isOpen = !_isOpen;
    notifyListeners();
  }

  void searchFood(String word) {
    DatabaseService().fullFoodList.then((value) {
      _searchedFood = value;
    }).whenComplete(() {
      _searchedFood
          .retainWhere((element) => element.name.toLowerCase().contains(word));
      notifyListeners();
    });
  }

  void searchClear() {
    _searchedFood.clear();
  }

  void loadMoreFood() {
    _loadMore = true;
    notifyListeners();
    _loadMore = false;
    notifyListeners();
  }

  List<Food> get getFoodList => _food;
  List<Food> get getSearchedFoodList => _searchedFood;
  bool get isSearching => _isOpen;
  bool get searchLoad => _searchLoading;
  bool get loadMore => _loadMore;
}
