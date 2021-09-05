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
  const FoodList({Key? key, required this.loggedIn}) : super(key: key);
  final bool loggedIn;

  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FilterListProvider>(
      builder: (context, provider, child) {
        final PageController _pageController = PageController();
        final List<Widget> _pages = [
          AllFoodList(loggedIn: widget.loggedIn),
          StarterFoodList(loggedIn: widget.loggedIn),
          SoupFoodList(loggedIn: widget.loggedIn),
          SaladFoodList(loggedIn: widget.loggedIn),
          SandwichFoodList(loggedIn: widget.loggedIn),
        ];

        return PageView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return _pages[provider.filterIndex];
            },
            controller: _pageController,
            onPageChanged: (num) {
              setState(() {
                provider.filterChange(num);
              });
            });
      },
    );
  }
}
