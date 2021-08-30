import 'package:dinner_planner/models/food.dart';
import 'package:dinner_planner/models/order.dart';
import 'package:dinner_planner/models/user.dart';
import 'package:dinner_planner/services/database.dart';
import 'package:dinner_planner/services/order_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderListTile extends StatelessWidget {
  const OrderListTile(
      {Key? key,
      required this.orderData,
      required this.index,
      required this.userID})
      : super(key: key);
  final OrderData orderData;
  final int index;
  final String? userID;

  @override
  Widget build(BuildContext context) {
    final Color vegColor = orderData.food.veg ? Colors.green : Colors.red;

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: OrderTileStatefulWidget(
          orderData: orderData, vegColor: vegColor, index: index, uid: userID),
    );
  }
}

class OrderTileStatefulWidget extends StatefulWidget {
  const OrderTileStatefulWidget(
      {Key? key,
      required this.orderData,
      required this.vegColor,
      required this.index,
      required this.uid})
      : super(key: key);
  final orderData;
  final Color vegColor;
  final int index;
  final String? uid;

  @override
  _OrderTileStatefulWidgetState createState() =>
      _OrderTileStatefulWidgetState();
}

class _OrderTileStatefulWidgetState extends State<OrderTileStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OrderListProvider(),
      builder: (context, child) => Consumer<OrderListProvider>(
        builder: (context, provider, child) {
          return ListTile(
            contentPadding: const EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            tileColor: Colors.white,
            leading: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.black26,
                  ),
                  constraints: BoxConstraints.tight(Size(80.0, 120.0)),
                ),
                Container(
                  constraints: BoxConstraints.tight(Size.square(18.0)),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      Icon(
                        Icons.circle_outlined,
                        color: widget.vegColor,
                        size: 16.0,
                      ),
                      Icon(
                        Icons.circle_rounded,
                        color: widget.vegColor,
                        size: 8.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            title: Text(widget.orderData.food.name,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.teal.shade900)),
            subtitle: Text("₹ ${widget.orderData.food.price.toString()}",
                style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        onPressed: () =>
                            provider.removeQty(widget.orderData, widget.index),
                        icon: Icon(Icons.remove, size: 10.0)),
                    Text("${provider.orderList[widget.index].qty}"),
                    IconButton(
                        onPressed: () =>
                            provider.addQty(widget.orderData, widget.index),
                        icon: Icon(Icons.add, size: 10.0)),
                  ],
                ),
                IconButton(
                    onPressed: () => DatabaseService(uid: widget.uid ?? null)
                        .updateUserOrders(widget.orderData),
                    icon: Icon(Icons.check_circle)),
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, "/item");
            },
          );
        },
      ),
    );
  }
}

// ChangeNotifierProvider<OrderListProvider>(
//         create: (_) => OrderListProvider(),
//         child: Consumer<OrderListProvider>(
//           builder: (context, provider, child) {
//             return IconButton(
//               icon: added ? Icon(Icons.close) : Icon(Icons.add),
//               onPressed: () {
//                 setState(() {
//                   if (widget.loggedIn) {
//                     added = !added;
//                     added
//                         ? provider.addOrder(
//                             OrderData(item: widget.food.foodId, qty: 1))
//                         : provider.removeOrder(
//                             OrderData(item: widget.food.foodId, qty: 1));
//                   } else {
//                     showCupertinoDialog<Widget>(
//                         context: context,
//                         builder: (builder) => DialogToLogin(),
//                         barrierDismissible: true);
//                   }
//                 });
//               },
//             );
//           },
//         ),
//       ),
