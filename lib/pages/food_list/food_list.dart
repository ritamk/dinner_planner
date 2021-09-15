import 'package:dinner_planner/pages/food_list/filters/all.dart';
import 'package:dinner_planner/pages/food_list/filters/salad.dart';
import 'package:dinner_planner/pages/food_list/filters/sandwich.dart';
import 'package:dinner_planner/pages/food_list/filters/soup.dart';
import 'package:dinner_planner/pages/food_list/filters/starter.dart';
import 'package:dinner_planner/services/filter_list_provider.dart';
import 'package:dinner_planner/services/food_list_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodList extends StatelessWidget {
  const FoodList({Key? key, required this.loggedIn}) : super(key: key);
  final bool loggedIn;

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;

    return Consumer<FoodListProvider>(builder: (context, foodProvider, child) {
      return Consumer<FilterListProvider>(
        builder: (context, filterProvider, child) {
          final List<Widget> _pages = [
            AllFoodList(
                loggedIn: loggedIn, height: _height, provider: foodProvider),
            StarterFoodList(
                loggedIn: loggedIn, height: _height, provider: foodProvider),
            SoupFoodList(
                loggedIn: loggedIn, height: _height, provider: foodProvider),
            SaladFoodList(
                loggedIn: loggedIn, height: _height, provider: foodProvider),
            SandwichFoodList(
                loggedIn: loggedIn, height: _height, provider: foodProvider),
          ];

          return PageView(
            children: _pages,
            controller: filterProvider.pageController,
            onPageChanged: (num) => filterProvider.filterChange(num),
          );
        },
      );
    });
  }
}
