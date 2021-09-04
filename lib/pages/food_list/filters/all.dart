import 'package:dinner_planner/models/food.dart';
import 'package:dinner_planner/pages/food_list/food_list_tile.dart';
import 'package:dinner_planner/shared/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllFoodList extends StatelessWidget {
  const AllFoodList({Key? key, required this.loggedIn}) : super(key: key);
  final bool loggedIn;

  @override
  Widget build(BuildContext context) {
    final List<Food> food = Provider.of<List<Food>>(context);

    return food.isEmpty
        ? Loading()
        : ListView.builder(
            itemCount: food.length,
            itemBuilder: (BuildContext context, int index) {
              return FoodTile(
                  food: food[index], loggedIn: loggedIn, index: index);
            },
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
          );
  }
}
