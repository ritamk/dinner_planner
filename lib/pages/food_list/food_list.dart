import 'package:dinner_planner/models/food.dart';
import 'package:dinner_planner/pages/food_list/filters/all.dart';
import 'package:dinner_planner/pages/food_list/filters/salad.dart';
import 'package:dinner_planner/pages/food_list/filters/sandwich.dart';
import 'package:dinner_planner/pages/food_list/filters/soup.dart';
import 'package:dinner_planner/pages/food_list/filters/starter.dart';
import 'package:dinner_planner/services/filter_list_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodList extends StatefulWidget {
  const FoodList({Key? key, required this.loggedIn, required this.food})
      : super(key: key);
  final bool loggedIn;
  final List<Food> food;

  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FilterListProvider>(
      builder: (context, provider, child) {
        final List<Widget> _pages = [
          AllFoodList(loggedIn: widget.loggedIn, food: widget.food),
          StarterFoodList(loggedIn: widget.loggedIn, food: widget.food),
          SoupFoodList(loggedIn: widget.loggedIn, food: widget.food),
          SaladFoodList(loggedIn: widget.loggedIn, food: widget.food),
          SandwichFoodList(loggedIn: widget.loggedIn, food: widget.food),
        ];

        return PageView(
          children: _pages,
          controller: provider.pageController,
          onPageChanged: (num) {
            setState(() {
              provider.filterChange(num);
            });
          },
        );
      },
    );
  }
}
