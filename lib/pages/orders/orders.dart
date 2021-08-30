import 'package:dinner_planner/models/user.dart';
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
      body: Center(
        child: Consumer<OrderListProvider>(
          builder: (context, provider, child) {
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
          },
        ),
      ),
    );
  }
}


          // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          // floatingActionButton: FloatingActionButton(
          //     onPressed: () => DatabaseService(uid: userID?.uid ?? null)
          //         .updateUserOrders(provider.orderList[0])),

// ListView.builder(
//             itemCount: provider.orders.length,
//             itemBuilder: (BuildContext context, int index) {
//               return OrderListTile(
//                   orderData: provider.orders[index],
//                   index: index,
//                   userID: userID?.uid ?? null);
//             },
//             physics: BouncingScrollPhysics(),
//           ),