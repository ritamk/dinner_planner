import 'package:dinner_planner/models/food.dart';
import 'package:dinner_planner/pages/dialog/dialog_to_login.dart';
import 'package:flutter/material.dart';

class FoodTileTest extends StatelessWidget {
  FoodTileTest({Key? key, required this.food, required this.loggedIn})
      : super(key: key);
  final Food food;

  final bool loggedIn;
  late Color vegColor = food.veg ? Colors.green : Colors.red;
  bool added = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListTileStateWidget(
          loggedIn: loggedIn, vegColor: vegColor, added: added, food: food),
    );
  }
}

class ListTileStateWidget extends StatefulWidget {
  ListTileStateWidget(
      {Key? key,
      required this.loggedIn,
      required this.vegColor,
      required this.added,
      required this.food})
      : super(key: key);
  final bool loggedIn;
  final Color vegColor;
  final Food food;
  bool added;

  @override
  _ListTileStateWidgetState createState() => _ListTileStateWidgetState();
}

class _ListTileStateWidgetState extends State<ListTileStateWidget> {
  bool adding = true;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      contentPadding: const EdgeInsets.all(2.0),
      leading: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          Container(
            height: 60.0,
            width: 60.0,
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                height: 20.0,
                width: 20.0,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              ),
              Icon(
                Icons.circle_outlined,
                color: widget.vegColor,
                size: 19.0,
              ),
              Icon(
                Icons.circle,
                color: widget.vegColor,
                size: 12.0,
              ),
            ],
          ),
        ],
      ),
      title: Text(
        "${widget.food.name}",
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        "₹ ${widget.food.price}",
        style: TextStyle(fontSize: 14.0, color: Colors.black45),
      ),
      trailing: IconButton(
        icon: Icon(widget.added ? Icons.close : Icons.add),
        onPressed: () {
          setState(() {
            widget.loggedIn
                ? widget.added = !widget.added
                : showDialog(
                    context: context,
                    builder: (builder) {
                      return DialogToLogin();
                    });
          });
        },
      ),
      tileColor: widget.added ? Colors.green : Colors.white,
    );
  }
}
