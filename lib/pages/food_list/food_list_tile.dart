import 'package:dinner_planner/models/food.dart';
import 'package:dinner_planner/models/order.dart';
import 'package:dinner_planner/pages/dialog/dialog_to_login.dart';
import 'package:dinner_planner/services/order_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodListTile extends StatelessWidget {
  FoodListTile({Key? key, required this.food, required this.loggedIn})
      : super(key: key);
  final bool loggedIn;
  final Food food;

  @override
  Widget build(BuildContext context) {
    final Color vegColor = food.veg ? Colors.green : Colors.red;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: ListTileStatefulWidget(
        vegColor: vegColor,
        food: food,
        loggedIn: loggedIn,
      ),
    );
  }
}

class ListTileStatefulWidget extends StatefulWidget {
  ListTileStatefulWidget(
      {Key? key,
      required this.loggedIn,
      required this.vegColor,
      required this.food})
      : super(key: key);
  final bool loggedIn;
  final Color vegColor;
  final Food food;

  @override
  _ListTileStatefulWidgetState createState() => _ListTileStatefulWidgetState();
}

class _ListTileStatefulWidgetState extends State<ListTileStatefulWidget> {
  bool added = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      tileColor: added ? Colors.green.shade50 : Colors.white,
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
      title: Text(widget.food.name,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.teal.shade900)),
      subtitle: Text("₹ ${widget.food.price.toString()}",
          style: TextStyle(fontWeight: FontWeight.bold)),
      trailing: ChangeNotifierProvider<OrderListProvider>(
        create: (_) => OrderListProvider(),
        child: Consumer<OrderListProvider>(
          builder: (context, provider, child) {
            return IconButton(
              icon: added ? Icon(Icons.close) : Icon(Icons.add),
              onPressed: () {
                setState(() {
                  if (widget.loggedIn) {
                    added = !added;
                    added
                        ? provider
                            .addOrder(OrderData(food: widget.food, qty: 1))
                        : provider
                            .removeOrder(OrderData(food: widget.food, qty: 1));
                  } else {
                    showCupertinoDialog<Widget>(
                        context: context,
                        builder: (builder) => DialogToLogin(),
                        barrierDismissible: true);
                  }
                });
              },
            );
          },
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, "/item");
      },
    );
  }
}

// IconButton(
//             icon: added ? Icon(Icons.close) : Icon(Icons.add),
//             onPressed: () {
//               setState(() {
//                 if (widget.loggedIn) {
//                   added = !added;
//                   added
//                       ? widget.order
//                           .add(OrderData(item: widget.food.foodId, qty: 1))
//                       : widget.order
//                           .remove(OrderData(item: widget.food.foodId, qty: 1));
//                 } else {
//                   showCupertinoDialog<Widget>(
//                       context: context,
//                       builder: (builder) => DialogToLogin(),
//                       barrierDismissible: true);
//                 }
//               });
//             },
//           ),