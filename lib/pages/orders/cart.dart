import 'package:dinner_planner/models/user.dart';
import 'package:dinner_planner/pages/orders/cart_tile.dart';
import 'package:dinner_planner/services/database.dart';
import 'package:dinner_planner/services/order_list_provider.dart';
import 'package:dinner_planner/shared/empty.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final UserID? userID = Provider.of<UserID?>(context);

    return Consumer<OrderListProvider>(builder: (context, provider, child) {
      return userID == null || provider.orderList.isEmpty
          ? EmptyPage()
          : Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () => Navigator.pop(context, "/"),
                  icon: Icon(Icons.arrow_back_ios),
                ),
                title: Text("Cart", style: TextStyle(color: Colors.blue)),
              ),
              body: ListView.builder(
                itemCount: provider.orderList.length,
                itemBuilder: (BuildContext context, int index) {
                  return CartListTile(
                      orderData: provider.orderList[index],
                      index: index,
                      userID: userID.uid);
                },
                physics: BouncingScrollPhysics(),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              floatingActionButton: FloatingActionButton.extended(
                tooltip: "Confirm Order",
                onPressed: () {
                  try {
                    provider.orderList.forEach((element) {
                      DatabaseService(uid: userID.uid)
                          .updateUserOrders(element);
                    });
                    setState(() {
                      provider.clearList();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text("Order Confirmed!\nPlease go to Orders page."),
                      action: SnackBarAction(
                          label: "Active Orders",
                          textColor: Colors.greenAccent,
                          onPressed: () =>
                              Navigator.popAndPushNamed(context, "/orders")),
                    ));
                  } catch (e) {
                    print(e.toString());
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "Couldn't place order.\nPlease try again later."),
                    ));
                  }
                },
                label: Row(
                  children: const <Widget>[
                    Icon(Icons.check, color: Colors.white),
                    SizedBox(width: 8.0),
                    Text("Confirm",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              bottomNavigationBar: BottomAppBar(
                color: Colors.lightBlue,
                // shape: CircularNotchedRectangle(),
                elevation: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(width: 16.0),
                      const Icon(Icons.shopping_bag_outlined,
                          color: Colors.white),
                      const SizedBox(width: 6.0),
                      RichText(
                        text: TextSpan(
                          text: "Order total: ",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          children: <InlineSpan>[
                            TextSpan(
                              text: "₹ ${provider.price}",
                              style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(0.9)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
    });
  }
}
