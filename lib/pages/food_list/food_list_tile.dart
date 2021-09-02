import 'package:dinner_planner/models/food.dart';
import 'package:dinner_planner/models/order.dart';
import 'package:dinner_planner/pages/dialog/dialog_to_login.dart';
import 'package:dinner_planner/services/order_list_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodTile extends StatefulWidget {
  FoodTile(
      {Key? key,
      required this.food,
      required this.loggedIn,
      required this.uid,
      required this.index})
      : super(key: key);
  final bool loggedIn;
  final Food food;
  final String? uid;
  final int index;

  @override
  _FoodTileState createState() => _FoodTileState();
}

class _FoodTileState extends State<FoodTile> with TickerProviderStateMixin {
  bool added = false;
  late Animation<double> _addClose;
  late Animation<double> _openClose;
  final Animatable<double> _tweenAddAnimatable =
      Tween<double>(begin: 0.0, end: 0.125);
  final Animatable<double> _tweenOpenAnimatable =
      Tween<double>(begin: 0.0, end: 0.5);
  final Animatable<double> _curveAnimatable =
      CurveTween(curve: Curves.easeInOut);
  late AnimationController _openClosecontroller;
  late AnimationController _addClosecontroller;

  @override
  void initState() {
    super.initState();
    _addClosecontroller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _openClosecontroller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _addClose =
        _addClosecontroller.drive(_tweenAddAnimatable.chain(_curveAnimatable));
    _openClose = _openClosecontroller
        .drive(_tweenOpenAnimatable.chain(_curveAnimatable));
  }

  @override
  void dispose() {
    _addClosecontroller.dispose();
    _openClosecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 2.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: added ? Colors.green.shade50 : Colors.white,
        ),
        child: ExpansionTile(
          childrenPadding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
          onExpansionChanged: (val) => val
              ? _openClosecontroller.forward()
              : _openClosecontroller.reverse(),
          leading: RotationTransition(
              turns: _openClose, child: const Icon(Icons.keyboard_arrow_down)),
          title: Text("${widget.food.name}",
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          trailing: Consumer<OrderListProvider>(
            builder: (context, provider, child) {
              return IconButton(
                icon: RotationTransition(
                  turns: _addClose,
                  child: const Icon(Icons.add),
                ),
                onPressed: () {
                  setState(() {
                    if (widget.loggedIn) {
                      added = !added;
                      if (added) {
                        provider.addOrder(OrderData(food: widget.food, qty: 1));
                        _addClosecontroller.forward();
                      } else {
                        provider.removeOrder(widget.food.name);
                        _addClosecontroller.reverse();
                      }
                    } else {
                      showCupertinoDialog<Widget>(
                          context: context,
                          builder: (builder) => const DialogToLogin(),
                          barrierDismissible: true);
                    }
                  });
                },
              );
            },
          ),
          children: <Widget>[
            imagePlaceholder(width),
            const SizedBox(height: 20.0),
            Text("${widget.food.about}",
                style: const TextStyle(
                    fontSize: 16.0, fontFamily: "KaiseiHarunoUmi-Medium")),
          ],
        ),
      ),
    );
  }

  Stack imagePlaceholder(double width) {
    return Stack(
      alignment: Alignment.topLeft,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
              bottomLeft: Radius.elliptical(width, 40.0),
              bottomRight: Radius.elliptical(width, 40.0),
            ),
            color: Colors.red.shade50,
          ),
          height: 200.0,
          width: double.infinity,
        ),
        Positioned(
          left: 5.0,
          top: 5.0,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              const Icon(Icons.circle, color: Colors.white, size: 30.0),
              Icon(Icons.radio_button_checked,
                  color: widget.food.veg ? Colors.green : Colors.red,
                  size: 22.0),
            ],
          ),
        ),
      ],
    );
  }
}
