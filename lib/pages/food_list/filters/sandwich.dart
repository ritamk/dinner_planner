import 'package:dinner_planner/pages/food_list/food_list_tile.dart';
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
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.provider.getFoodList.isEmpty
        ? Loading()
        : RefreshIndicator(
            onRefresh: () async => setState(() {}),
            child: ListView.builder(
              itemCount: widget.provider.isSearching
                  ? widget.provider.getSearchedFoodList.length
                  : widget.provider.getFoodList.length,
              itemBuilder: (BuildContext context, int index) {
                return widget.provider.isSearching
                    ? widget.provider.getSearchedFoodList[index].type ==
                            "sandwich"
                        ? FoodTile(
                            food: widget.provider.getSearchedFoodList[index],
                            loggedIn: widget.loggedIn,
                            index: index)
                        : const SizedBox.shrink()
                    : widget.provider.getFoodList[index].type == "sandwich"
                        ? FoodTile(
                            food: widget.provider.getFoodList[index],
                            loggedIn: widget.loggedIn,
                            index: index)
                        : const SizedBox.shrink();
              },
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
            ),
          );
  }
}
