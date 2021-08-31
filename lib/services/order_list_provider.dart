import 'package:dinner_planner/models/order.dart';
import 'package:flutter/cupertino.dart';

class OrderListProvider extends ChangeNotifier {
  List<OrderData> _orders = [];

  void addOrder(OrderData orderData) {
    _orders.add(OrderData(food: orderData.food, qty: orderData.qty));
    notifyListeners();
  }

  void removeOrder(String name) {
    _orders.removeWhere((element) => element.food.name == name);
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

  int get price {
    int price = 0;
    _orders.forEach((element) {
      price += element.food.price * element.qty;
    });
    return price;
  }

  List<OrderData> get orderList => _orders;
}
