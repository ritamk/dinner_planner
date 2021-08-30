import 'package:dinner_planner/models/user.dart';
import 'package:dinner_planner/pages/food_list/food_list_tile.dart';
import 'package:dinner_planner/pages/orders/order_tile.dart';
import 'package:dinner_planner/services/database.dart';
import 'package:dinner_planner/services/order_list.dart';
import 'package:dinner_planner/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserID? userID = Provider.of<UserID?>(context);

    return Scaffold(
      appBar: AppBar(
        shape: appBarShapeBorder(),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ChangeNotifierProvider<OrderListProvider>(
        create: (_) => OrderListProvider(),
        builder: (context, child) =>
            Consumer<OrderListProvider>(builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.orderList.length,
            itemBuilder: (BuildContext context, int index) {
              return OrderListTile(
                  orderData: provider.orderList[index],
                  index: index,
                  userID: userID?.uid ?? null);
            },
            physics: BouncingScrollPhysics(),
          );
        }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(onPressed: () => null),
    );
  }
}

// FloatingActionButton(
//           onPressed: () =>
//               DatabaseService(uid: userID?.uid ?? null).updateUserOrders(data)), 