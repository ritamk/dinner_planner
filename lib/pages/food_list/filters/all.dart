import 'package:dinner_planner/pages/food_list/food_list_tile.dart';
import 'package:dinner_planner/services/database.dart';
import 'package:dinner_planner/services/food_list_provider.dart';
import 'package:dinner_planner/shared/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// The category containing all food items regardless the type.
class AllFoodList extends StatefulWidget {
  const AllFoodList({Key? key, required this.loggedIn, required this.provider})
      : super(key: key);

  /// Determines if the user is logged in or not and passes
  /// the info down to the list children.
  final bool loggedIn;

  /// The provider containing the FoodListProvider
  /// change notifier class.
  final FoodListProvider provider;

  @override
  State<AllFoodList> createState() => _AllFoodListState();
}

class _AllFoodListState extends State<AllFoodList>
    with AutomaticKeepAliveClientMixin {
  /// Helps in keeping track of the scroll position.
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Initial data is loaded with the getInitFood method.
    getInitFood().whenComplete(() => setState(() {}));

    // _scrollcontroller is used to determine when the user
    // reaches the end of list, this calls getMoreFood() method.
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        getMoreFood().whenComplete(() => setState(() {}));
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Keeps the state of the widget alive even when it's not in view.
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // Shows Loading widget if the _food list is empty.
    return widget.provider.getFoodList.isEmpty
        ? Loading()
        : RefreshIndicator(
            // Calls getInitFood() when the list is pulled down to be refreshed.
            onRefresh: () => getInitFood().whenComplete(() => setState(() {})),
            child: ListView.builder(
              // If bool isSearching is true in FoodListProvider class
              // then _searchedFood list is returned instead of _food.
              itemCount: widget.provider.isSearching
                  ? widget.provider.getSearchedFoodList.length
                  : widget.provider.getFoodList.length,
              itemBuilder: (BuildContext context, int index) {
                // FoodTile widget is returned for each list item.
                return FoodTile(
                    food: widget.provider.isSearching
                        ? widget.provider.getSearchedFoodList[index]
                        : widget.provider.getFoodList[index],
                    loggedIn: widget.loggedIn,
                    index: index);
              },
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              controller: _scrollController,
            ),
          );
  }

  /**
   * Initialises the first batch of data in the _food
   * list in FoodListProvider class.
   */
  Future<void> getInitFood() async {
    await DatabaseService()
        .foodList
        .then((value) => widget.provider.initFood(value));
  }

  /**
   * Calls the addFood() method in FoodListProvider class
   * which adds the subsequent batches of data into the
   * _food list there.
   */
  Future<void> getMoreFood() async {
    await DatabaseService()
        .moreFoodList
        .then((value) => widget.provider.addFood(value));
  }
}
