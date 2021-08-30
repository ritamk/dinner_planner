import 'package:dinner_planner/models/order.dart';
import 'package:flutter/cupertino.dart';

class OrderListProvider extends ChangeNotifier {
  List<OrderData> _orders = [];

  void addOrder(OrderData orderData) {
    _orders.add(OrderData(food: orderData.food, qty: orderData.qty));
    notifyListeners();
  }

  void removeOrder(OrderData orderData) {
    _orders.remove(OrderData(food: orderData.food, qty: orderData.qty));
    notifyListeners();
  }

  void addQty(OrderData orderData, int index) {
    _orders[index].qty += 1;
    notifyListeners();
  }

  void removeQty(OrderData orderData, int index) {
    (_orders[index].qty == 1)
        ? _orders[index].qty -= 1
        : _orders[index].qty = 1;
    notifyListeners();
  }

  List<OrderData> get orderList => _orders;
}
