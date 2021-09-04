import 'package:dinner_planner/pages/food_list/filters/all.dart';
import 'package:dinner_planner/pages/food_list/filters/salad.dart';
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
        ];

        return PageView.builder(
            itemCount: 4,
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

// @override
//   Widget build(BuildContext context) {
//     final List<Food> food = Provider.of<List<Food>>(context);

//     return food.isEmpty
//         ? Loading()
//         : ListView.builder(
//             itemCount: food.length,
//             itemBuilder: (BuildContext context, int index) {
//               return Consumer<FilterListProvider>(
//                 builder: (context, provider, child) {
//                   switch (provider.filteredString) {
//                     case "All":
//                       return FoodTile(
//                           food: food[index], loggedIn: loggedIn, index: index);
//                     case "Starters":
//                       return filterFood(
//                           "starter", food[index], loggedIn, index);
//                     case "Soups":
//                       return filterFood("soup", food[index], loggedIn, index);
//                     case "Salads":
//                       return filterFood("salad", food[index], loggedIn, index);
//                     default:
//                       return FoodTile(
//                           food: food[index], loggedIn: loggedIn, index: index);
//                   }
//                 },
//               );
//             },
//             scrollDirection: Axis.vertical,
//             physics: const BouncingScrollPhysics(),
//           );
//   }

//   Widget filterFood(String type, Food food, bool loggedIn, int index) {
//     return type == food.type
//         ? FoodTile(food: food, loggedIn: loggedIn, index: index)
//         : const Padding(padding: EdgeInsets.all(0.0));
//   }