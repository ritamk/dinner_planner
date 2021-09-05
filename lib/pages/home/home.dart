import 'package:dinner_planner/models/food.dart';
import 'package:dinner_planner/models/user.dart';
import 'package:dinner_planner/pages/home/drawer.dart';
import 'package:dinner_planner/pages/food_list/food_list.dart';
import 'package:dinner_planner/pages/home/filter_togglebar.dart';
import 'package:dinner_planner/pages/home/search_field.dart';
import 'package:dinner_planner/services/database.dart';
import 'package:dinner_planner/services/filter_list_provider.dart';
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
          toolbarHeight: 140.0,
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu, color: Colors.blue),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          }),
          title: SearchField(),
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
                      Icon(Icons.shopping_cart, color: Colors.blue),
                      provider.orderList.isEmpty
                          ? const Padding(padding: EdgeInsets.all(0.0))
                          : Stack(
                              alignment: Alignment.center,
                              children: <Icon>[
                                Icon(Icons.circle,
                                    color: Colors.white, size: 14.0),
                                Icon(Icons.circle,
                                    color: Colors.red[700], size: 10.0),
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
          bottom: PreferredSize(
              preferredSize: Size(double.infinity, 100.0),
              child: FilterToggleButtonWidget()),
        ),
        body: StreamProvider<List<Food>>.value(
          value: DatabaseService().food,
          initialData: [],
          child: FoodList(loggedIn: loggedIn),
        ),
        drawer: HomeDrawer(
          loginWidget: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
            leading: Icon(Icons.login_rounded),
            title: Text("Log In", style: TextStyle(fontSize: 16.0)),
            trailing: Icon(Icons.arrow_right),
            onTap: () => Navigator.pushNamed(context, "/auth"),
          ),
        ),
      ),
    );
  }
}
