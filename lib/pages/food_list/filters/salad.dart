import 'package:dinner_planner/pages/food_list/food_list_tile.dart';
import 'package:dinner_planner/services/food_list_provider.dart';
import 'package:dinner_planner/shared/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Category containing only food items marked as "salad" under "type" data.
class SaladFoodList extends StatefulWidget {
  const SaladFoodList(
      {Key? key, required this.loggedIn, required this.provider})
      : super(key: key);
  final bool loggedIn;
  final FoodListProvider provider;

  @override
  State<SaladFoodList> createState() => _SaladFoodListState();
}

class _SaladFoodListState extends State<SaladFoodList>
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
                // Here an extra layer of checking takes place
                // as the list only returns items marked as "salad" in
                // their "type" data.
                return widget.provider.isSearching
                    ? widget.provider.getSearchedFoodList[index].type == "salad"
                        ? FoodTile(
                            food: widget.provider.getSearchedFoodList[index],
                            loggedIn: widget.loggedIn,
                            index: index)
                        : const SizedBox.shrink()
                    : widget.provider.getFoodList[index].type == "salad"
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
