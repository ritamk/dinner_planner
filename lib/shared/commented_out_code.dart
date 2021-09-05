
// PreferredSize(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: const FilterToggleButtonWidget(),
//                   ),
//                 ],
//               ),
//             ),
//             preferredSize: Size.fromHeight(20.0),
//           ),

// class FilterToggleButtonWidget extends StatefulWidget {
//   const FilterToggleButtonWidget({Key? key}) : super(key: key);

//   @override
//   _FilterToggleButtonWidgetState createState() =>
//       _FilterToggleButtonWidgetState();
// }

// class _FilterToggleButtonWidgetState extends State<FilterToggleButtonWidget> {
//   List<bool> selectedIndex = [];
//   Color noColor = Colors.black.withAlpha(0);

//   @override
//   void initState() {
//     super.initState();
//     selectedIndex = [
//       true,
//       false,
//       false,
//       false,
//     ];
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ToggleButtons(
//       borderColor: noColor,
//       selectedBorderColor: noColor,
//       splashColor: noColor,
//       children: [
//         filterContainerWidget(selectedFilter[0], selectedIndex[0]),
//         filterContainerWidget(selectedFilter[1], selectedIndex[1]),
//         filterContainerWidget(selectedFilter[2], selectedIndex[2]),
//         filterContainerWidget(selectedFilter[3], selectedIndex[3]),
//       ],
//       isSelected: selectedIndex,
//       onPressed: (index) {
//         setState(() {
//           for (int i = 0; i < selectedIndex.length; i++) {
//             selectedIndex[i] = i == index;
//             filterIndex.value = index;
//           }
//         });
//       },
//     );
//   }

//   Widget filterContainerWidget(String name, bool selected) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Container(
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(30.0),
//           color: selected ? Colors.white30 : Colors.white,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//           child: Text(name,
//               style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                   color: selected ? Colors.white : Colors.black54),
//               textAlign: TextAlign.center),
//         ),
//       ),
//     );
//   }
// }


// ListView.builder(
//             itemCount: food.length,
//             itemBuilder: (BuildContext context, int index) {
//               switch (filter) {
//                 case "All":
//                   return FoodTileTest(
//                       food: food[index],
//                       loggedIn: loggedIn,
//                       uid: userID?.uid,
//                       index: index);
//                 case "Starters":
//                   return filterFood(
//                       "starter", food[index], loggedIn, userID?.uid, index);
//                 case "Soups":
//                   return filterFood(
//                       "soup", food[index], loggedIn, userID?.uid, index);
//                 case "Salads":
//                   return filterFood(
//                       "salad", food[index], loggedIn, userID?.uid, index);
//                 default:
//                   return FoodListTile(
//                       food: food[index],
//                       loggedIn: loggedIn,
//                       uid: userID?.uid,
//                       index: index);
//               }
//             },
//             scrollDirection: Axis.vertical,
//             physics: const BouncingScrollPhysics(),
//           );



// Compute (Isolate):-

//     Future<List<Food?>> filteredTileWidgets() async {
//       return await compute<FilterComparisonIsolate, List<Food?>>(
//           sortedList,
//           FilterComparisonIsolate(
//               filter: filter, food: food, loggedIn: loggedIn));
//     } 

// List<Food?> sortedList(FilterComparisonIsolate data) {
//   final List<Food?> list =
//       List.generate(data.food.length, (index) => data.food[index]);
//   final List<Food?> listSoup = List.generate(
//     data.food.length,
//     (index) => data.food[index].type == "soup" ? data.food[index] : null,
//   );
//   final List<Food?> listSalad = List.generate(
//     data.food.length,
//     (index) => data.food[index].type == "salad" ? data.food[index] : null,
//   );
//   final List<Food?> listStarter = List.generate(
//     data.food.length,
//     (index) => data.food[index].type == "starter" ? data.food[index] : null,
//   );

//   switch (data.filter) {
//     case "All":
//       return list;
//     case "Starters":
//       listStarter.removeWhere((element) => element == null);
//       return listStarter;
//     case "Soups":
//       listSoup.removeWhere((element) => element == null);
//       return listSoup;
//     case "Salads":
//       listSalad.removeWhere((element) => element == null);
//       return listSalad;
//     default:
//       throw "Something went wrong with sortedListIsolate";
//   }
// }
 


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