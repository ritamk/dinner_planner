import 'package:cloud_firestore/cloud_firestore.dart';

class OrderData {
  final DocumentReference item;
  final int qty;
  final Timestamp time;

  OrderData({required this.item, required this.qty, required this.time});
}
