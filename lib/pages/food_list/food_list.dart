import 'package:dinner_planner/models/food.dart';
import 'package:dinner_planner/models/user.dart';
import 'package:dinner_planner/pages/food_list/food_list_tile.dart';
import 'package:dinner_planner/shared/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodList extends StatelessWidget {
  const FoodList({Key? key, required this.filter}) : super(key: key);
  final String filter;

  @override
  Widget build(BuildContext context) {
    final UserID? userID = Provider.of<UserID?>(context);
    final List<Food> food = Provider.of<List<Food>>(context);
    final bool loggedIn = userID != null ? true : false;

    return food.isEmpty
        ? Loading()
        : ListView.builder(
            itemCount: food.length,
            itemBuilder: (BuildContext context, int index) {
              switch (filter) {
                case "All":
                  return FoodListTile(
                      food: food[index],
                      loggedIn: loggedIn,
                      uid: userID?.uid,
                      index: index);
                case "Starters":
                  return filterFood(
                      "starter", food[index], loggedIn, userID?.uid, index);
                case "Soups":
                  return filterFood(
                      "soup", food[index], loggedIn, userID?.uid, index);
                case "Salads":
                  return filterFood(
                      "salad", food[index], loggedIn, userID?.uid, index);
                default:
                  return FoodListTile(
                      food: food[index],
                      loggedIn: loggedIn,
                      uid: userID?.uid,
                      index: index);
              }
            },
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
          );
  }

  Widget filterFood(
      String type, Food food, bool loggedIn, String? uid, int index) {
    return type == food.type
        ? FoodListTile(food: food, loggedIn: loggedIn, uid: uid, index: index)
        : const Padding(padding: EdgeInsets.all(0.0));
  }
}

   /* Future<List<Food?>> filteredTileWidgets() async {
      return await compute<FilterComparisonIsolate, List<Food?>>(
          sortedList,
          FilterComparisonIsolate(
              filter: filter, food: food, loggedIn: loggedIn));
    } 

List<Food?> sortedList(FilterComparisonIsolate data) {
  final List<Food?> list =
      List.generate(data.food.length, (index) => data.food[index]);
  final List<Food?> listSoup = List.generate(
    data.food.length,
    (index) => data.food[index].type == "soup" ? data.food[index] : null,
  );
  final List<Food?> listSalad = List.generate(
    data.food.length,
    (index) => data.food[index].type == "salad" ? data.food[index] : null,
  );
  final List<Food?> listStarter = List.generate(
    data.food.length,
    (index) => data.food[index].type == "starter" ? data.food[index] : null,
  );

  switch (data.filter) {
    case "All":
      return list;
    case "Starters":
      listStarter.removeWhere((element) => element == null);
      return listStarter;
    case "Soups":
      listSoup.removeWhere((element) => element == null);
      return listSoup;
    case "Salads":
      listSalad.removeWhere((element) => element == null);
      return listSalad;
    default:
      throw "Something went wrong with sortedListIsolate";
  }
}
 */
