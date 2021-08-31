import 'package:dinner_planner/models/user.dart';
import 'package:dinner_planner/pages/orders/order_tile.dart';
import 'package:dinner_planner/services/database.dart';
import 'package:dinner_planner/services/order_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final UserID? userID = Provider.of<UserID?>(context);

    return Consumer<OrderListProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context, "/"),
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: provider.orderList.length,
            itemBuilder: (BuildContext context, int index) {
              return OrderListTile(
                  orderData: provider.orderList[index],
                  index: index,
                  userID: userID?.uid ?? null);
            },
            physics: BouncingScrollPhysics(),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () => provider.orderList.forEach((element) {
                  DatabaseService(uid: userID?.uid ?? null)
                      .updateUserOrders(element);
                  print(provider.price.toString());
                }),
            label: Text("Confirm")),
      );
    });
  }
}

// IconButton(
//                     onPressed: () => DatabaseService(uid: widget.uid ?? null)
//                         .updateUserOrders(widget.orderData),
//                     icon: Icon(Icons.check_circle)),
//               ],
//             ),
//             IconButton(
//                 onPressed: () => provider.removeOrder(widget.orderData),
//                 icon: Icon(Icons.delete))