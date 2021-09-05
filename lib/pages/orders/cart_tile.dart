import 'package:dinner_planner/models/order.dart';
import 'package:dinner_planner/services/order_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartListTile extends StatelessWidget {
  const CartListTile(
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
  final OrderData orderData;
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
    return Consumer<OrderListProvider>(builder: (context, provider, child) {
      return ListTile(
        contentPadding: const EdgeInsets.all(15.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        tileColor: Colors.white,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
                onPressed: () =>
                    provider.removeQty(widget.orderData, widget.index),
                icon: Icon(Icons.remove_circle, size: 18.0)),
            Text("${provider.orderList[widget.index].qty}",
                style: TextStyle(fontSize: 17.0)),
            IconButton(
                onPressed: () =>
                    provider.addQty(widget.orderData, widget.index),
                icon: Icon(Icons.add_circle, size: 18.0)),
          ],
        ),
        title: Text(widget.orderData.food.name,
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900)),
        subtitle: Text("₹ ${widget.orderData.food.price.toString()}"),
        trailing: IconButton(
            onPressed: () => provider.removeOrder(widget.orderData.food.name),
            icon: Icon(Icons.delete)),
      );
    });
  }
}
