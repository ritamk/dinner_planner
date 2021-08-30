import 'package:dinner_planner/models/order.dart';
import 'package:flutter/cupertino.dart';

class OrderListProvider extends ChangeNotifier {
  List<OrderData> orders = [];

  void addOrder(OrderData orderData) {
    orders.add(OrderData(food: orderData.food, qty: orderData.qty));
    notifyListeners();
  }

  void removeOrder(OrderData orderData) {
    orders.remove(OrderData(food: orderData.food, qty: orderData.qty));
    notifyListeners();
  }

  void addQty(OrderData orderData, int index) => orders[index].qty += 1;

  void removeQty(OrderData orderData, int index) =>
      (orders[index].qty > 1) ? orders[index].qty -= 1 : orders[index].qty = 1;

  List<OrderData> get orderList => orders;
}
