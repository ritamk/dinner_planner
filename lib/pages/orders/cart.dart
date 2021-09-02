import 'package:dinner_planner/models/user.dart';
import 'package:dinner_planner/pages/orders/order_tile.dart';
import 'package:dinner_planner/services/database.dart';
import 'package:dinner_planner/services/order_list_provider.dart';
import 'package:dinner_planner/shared/empty.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserID? userID = Provider.of<UserID?>(context);

    return Consumer<OrderListProvider>(builder: (context, provider, child) {
      return userID != null
          ? Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () => Navigator.pop(context, "/"),
                  icon: Icon(Icons.arrow_back_ios),
                ),
                title: Text("Orders", style: TextStyle(color: Colors.blue)),
              ),
              body: ListView.builder(
                itemCount: provider.orderList.length,
                itemBuilder: (BuildContext context, int index) {
                  return OrderListTile(
                      orderData: provider.orderList[index],
                      index: index,
                      userID: userID.uid);
                },
                physics: BouncingScrollPhysics(),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
              floatingActionButton: FloatingActionButton(
                tooltip: "Confirm Order",
                onPressed: () {
                  try {
                    provider.orderList.forEach((element) {
                      DatabaseService(uid: userID.uid)
                          .updateUserOrders(element);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text("Order Confirmed!\nPlease go to Orders page."),
                    ));
                  } catch (e) {
                    print(e.toString());
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "Couldn't place order.\nPlease try again later."),
                    ));
                  }
                },
                child: Icon(Icons.check, color: Colors.white),
              ),
              bottomNavigationBar: BottomAppBar(
                color: Colors.lightBlue,
                shape: CircularNotchedRectangle(),
                elevation: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(width: 16.0),
                      RichText(
                        text: TextSpan(
                          text: "Order total: ",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          children: <InlineSpan>[
                            TextSpan(
                              text: "₹ ${provider.price}",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : EmptyPage();
    });
  }
}
