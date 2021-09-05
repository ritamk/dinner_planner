import 'package:dinner_planner/models/food.dart';
import 'package:dinner_planner/pages/food_list/food_list_tile.dart';
import 'package:dinner_planner/shared/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SandwichFoodList extends StatelessWidget {
  const SandwichFoodList({Key? key, required this.loggedIn}) : super(key: key);
  final bool loggedIn;

  @override
  Widget build(BuildContext context) {
    final List<Food> food = Provider.of<List<Food>>(context);

    return food.isEmpty
        ? Loading()
        : ListView.builder(
            itemCount: food.length,
            itemBuilder: (BuildContext context, int index) {
              return food[index].type == "sandwich"
                  ? FoodTile(
                      food: food[index], loggedIn: loggedIn, index: index)
                  : const Padding(padding: EdgeInsets.all(0.0));
            },
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
          );
  }
}
