import 'package:dinner_planner/models/user.dart';
import 'package:dinner_planner/pages/home/drawer.dart';
import 'package:dinner_planner/pages/food_list/food_list.dart';
import 'package:dinner_planner/pages/home/filter_togglebar.dart';
import 'package:dinner_planner/pages/home/search_field.dart';
import 'package:dinner_planner/services/food_list_provider.dart';
import 'package:dinner_planner/services/order_list_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserID? userID = Provider.of<UserID?>(context);
    final bool loggedIn = userID != null ? true : false;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 130.0,
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu, color: Colors.blue),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          }),
          title: Consumer<FoodListProvider>(
              builder: (context, provider, child) =>
                  SearchField(foodListProvider: provider)),
          centerTitle: false,
          actions: <Widget>[
            Tooltip(
              message: 'Cart',
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/cart");
                },
                icon: Consumer<OrderListProvider>(
                    builder: (context, provider, child) {
                  return Stack(
                    alignment: Alignment.topRight,
                    children: <Widget>[
                      const Icon(Icons.shopping_cart, color: Colors.blue),
                      provider.orderList.isEmpty
                          ? const Padding(padding: EdgeInsets.all(0.0))
                          : Stack(
                              alignment: Alignment.center,
                              children: <Icon>[
                                const Icon(Icons.circle,
                                    color: Colors.white, size: 14.0),
                                Icon(Icons.circle,
                                    color: Colors.red.shade700, size: 10.0),
                              ],
                            ),
                    ],
                  );
                }),
              ),
            ),
            Tooltip(
              message: 'Filter/Sort',
              child: IconButton(
                  onPressed: () {}, icon: Icon(Icons.tune, color: Colors.blue)),
            ),
            const SizedBox(width: 8.0),
          ],
          bottom: const PreferredSize(
              preferredSize: Size(double.infinity, double.minPositive),
              child: FilterToggleButtonWidget()),
        ),
        body: FoodList(loggedIn: loggedIn),
        drawer: HomeDrawer(),
      ),
    );
  }
}


// Consumer<FoodListProvider>(builder: (context, provider, child) {
//           return FutureBuilder<List<Food>>(
//             future: DatabaseService().foodList,
//             initialData: [],
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               if (snapshot.hasData) {
//                 provider.addFood(snapshot.data);
//                 return FoodList(loggedIn: loggedIn);
//               } else if (snapshot.hasError) {
//                 return const EmptyBody(
//                     message:
//                         "Something went wrong.\nPlease check your network connection.");
//               } else {
//                 return const Loading();
//               }
//             },
//           );
//         }),