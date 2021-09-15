import 'package:dinner_planner/models/food.dart';
import 'package:dinner_planner/pages/food_list/food_list_tile.dart';
import 'package:dinner_planner/services/database.dart';
import 'package:dinner_planner/services/food_list_provider.dart';
import 'package:dinner_planner/shared/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SandwichFoodList extends StatefulWidget {
  const SandwichFoodList(
      {Key? key,
      required this.loggedIn,
      required this.height,
      required this.provider})
      : super(key: key);
  final bool loggedIn;
  final double height;
  final FoodListProvider provider;
  @override
  State<SandwichFoodList> createState() => _SandwichFoodListState();
}

class _SandwichFoodListState extends State<SandwichFoodList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<List<Food>>(
        future: DatabaseService().foodList,
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.data.isEmpty
              ? Loading()
              : RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      ;
                    });
                  },
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return snapshot.data[index].type == "sandwich"
                          ? FoodTile(
                              food: snapshot.data[index],
                              loggedIn: widget.loggedIn,
                              index: index)
                          : const SizedBox.shrink();
                    },
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                  ),
                );
        });
  }

  @override
  bool get wantKeepAlive => true;
}
