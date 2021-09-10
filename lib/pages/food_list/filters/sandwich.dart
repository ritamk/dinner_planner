import 'package:dinner_planner/models/food.dart';
import 'package:dinner_planner/pages/food_list/food_list_tile.dart';
import 'package:dinner_planner/shared/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SandwichFoodList extends StatelessWidget {
  const SandwichFoodList({Key? key, required this.loggedIn, required this.food})
      : super(key: key);
  final bool loggedIn;
  final List<Food> food;

  @override
  Widget build(BuildContext context) {
    return food.isEmpty
        ? Loading()
        : ListView.builder(
            itemCount: food.length,
            itemBuilder: (BuildContext context, int index) {
              return food[index].type == "sandwich"
                  ? FoodTile(
                      food: food[index], loggedIn: loggedIn, index: index)
                  : const SizedBox.shrink();
            },
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
          );
  }
}
