import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dinner_planner/models/food.dart';

class OrderData {
  final Food food;
  int qty;
  final Timestamp? time;

  OrderData({required this.food, required this.qty, this.time});
}

class FetchOrderData {
  final List? foodList;

  FetchOrderData({this.foodList});
}
