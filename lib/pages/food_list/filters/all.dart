import 'package:dinner_planner/pages/food_list/food_list_tile.dart';
import 'package:dinner_planner/services/database.dart';
import 'package:dinner_planner/services/food_list_provider.dart';
import 'package:dinner_planner/shared/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AllFoodList extends StatefulWidget {
  const AllFoodList(
      {Key? key,
      required this.loggedIn,
      required this.height,
      required this.provider})
      : super(key: key);
  final bool loggedIn;
  final double height;
  final FoodListProvider provider;

  @override
  State<AllFoodList> createState() => _AllFoodListState();
}

class _AllFoodListState extends State<AllFoodList>
    with AutomaticKeepAliveClientMixin {
  ScrollController _scrollController = ScrollController();

  Future<void> getInitFood() async {
    await DatabaseService()
        .foodList
        .then((value) => widget.provider.initFood(value));
  }

  Future<void> getMoreFood() async {
    await DatabaseService()
        .moreFoodList
        .then((value) => widget.provider.addFood(value));
  }

  @override
  void initState() {
    super.initState();
    getInitFood().whenComplete(() => setState(() {}));
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

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.provider.getFoodList.isEmpty) {
      return Loading();
    } else {
      return RefreshIndicator(
        onRefresh: () => getInitFood().whenComplete(() => setState(() {})),
        child: ListView.builder(
          itemCount: widget.provider.isSearching
              ? widget.provider.getSearchedFoodList.length
              : widget.provider.getFoodList.length,
          itemBuilder: (BuildContext context, int index) {
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
  }
}
