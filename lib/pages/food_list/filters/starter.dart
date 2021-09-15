import 'package:dinner_planner/models/food.dart';
import 'package:dinner_planner/pages/food_list/food_list_tile.dart';
import 'package:dinner_planner/services/database.dart';
import 'package:dinner_planner/services/food_list_provider.dart';
import 'package:dinner_planner/shared/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StarterFoodList extends StatefulWidget {
  const StarterFoodList(
      {Key? key,
      required this.loggedIn,
      required this.height,
      required this.provider})
      : super(key: key);
  final bool loggedIn;
  final double height;
  final FoodListProvider provider;

  @override
  State<StarterFoodList> createState() => _StarterFoodListState();
}

class _StarterFoodListState extends State<StarterFoodList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return widget.provider.getFoodList.isEmpty
        ? Loading()
        : ListView.builder(
            itemCount: widget.provider.getFoodList.length,
            itemBuilder: (BuildContext context, int index) {
              return widget.provider.getFoodList[index].type == "starter"
                  ? FoodTile(
                      food: widget.provider.getFoodList[index],
                      loggedIn: widget.loggedIn,
                      index: index)
                  : const SizedBox.shrink();
            },
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
          );
  }

  @override
  bool get wantKeepAlive => true;
}
