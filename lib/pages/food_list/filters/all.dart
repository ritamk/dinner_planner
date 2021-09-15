import 'package:dinner_planner/models/food.dart';
import 'package:dinner_planner/pages/food_list/food_list_tile.dart';
import 'package:dinner_planner/services/database.dart';
import 'package:dinner_planner/services/food_list_provider.dart';
import 'package:dinner_planner/shared/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<List<Food>>(
        future: DatabaseService().foodList,
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data.isEmpty) {
            return Loading();
          } else {
            widget.provider.initFood(snapshot.data);

            return RefreshIndicator(
              onRefresh: () async => setState(() {}),
              child: ListView.builder(
                itemCount: widget.provider.getFoodList.length,
                itemBuilder: (BuildContext context, int index) {
                  return FoodTile(
                      food: widget.provider.getFoodList[index],
                      loggedIn: widget.loggedIn,
                      index: index);
                },
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
              ),
            );
          }
        });
  }

  @override
  bool get wantKeepAlive => true;
}


// class AllFoodList extends StatefulWidget {
//   const AllFoodList(
//       {Key? key,
//       required this.loggedIn,
//       required this.height,
//       required this.provider})
//       : super(key: key);
//   final bool loggedIn;
//   final double height;
//   final FoodListProvider provider;

//   @override
//   State<AllFoodList> createState() => _AllFoodListState();
// }

// class _AllFoodListState extends State<AllFoodList>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     return FutureBuilder<List<Food>>(
//         future: DatabaseService().foodList,
//         initialData: [],
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.data.isEmpty) {
//             return Loading();
//           } else {
//             widget.provider.addFood(snapshot.data);

//             return RefreshIndicator(
//               onRefresh: () async => setState(() {}),
//               child: ListView.builder(
//                 itemCount: widget.provider.getFoodList.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return FoodTile(
//                       food: widget.provider.getFoodList[index],
//                       loggedIn: widget.loggedIn,
//                       index: index);
//                 },
//                 scrollDirection: Axis.vertical,
//                 physics: const BouncingScrollPhysics(),
//               ),
//             );
//           }
//         });
//   }

//   @override
//   bool get wantKeepAlive => true;
// }


// class AllFoodList extends StatelessWidget {
//   const AllFoodList({Key? key, required this.loggedIn, required this.food})
//       : super(key: key);
//   final bool loggedIn;
//   final List<Food> food;

//   @override
//   Widget build(BuildContext context) {
//     final ScrollController _scrollController = ScrollController();

//     return food.isEmpty
//         ? Loading()
//         : ListView.builder(
//             itemCount: food.length,
//             itemBuilder: (BuildContext context, int index) {
//               return FoodTile(
//                   food: food[index], loggedIn: loggedIn, index: index);
//             },
//             scrollDirection: Axis.vertical,
//             physics: const BouncingScrollPhysics(),
//             controller: _scrollController,
//           );
//   }
// }
