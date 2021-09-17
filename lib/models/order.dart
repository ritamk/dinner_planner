import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinner_planner/models/food.dart';

class OrderData {
  final Food food;
  int qty;
  final Timestamp? time;

  OrderData({required this.food, required this.qty, this.time});
}

class FetchOrderData {
  final DocumentReference item;
  final int price;
  final int qty;
  final String name;
  final Timestamp time;

  FetchOrderData(
      {required this.item,
      required this.price,
      required this.qty,
      required this.name,
      required this.time});
}
