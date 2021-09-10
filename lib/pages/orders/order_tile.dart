import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  const OrderTile(
      {Key? key,
      required this.name,
      required this.qty,
      required this.price,
      required this.time})
      : super(key: key);
  final String name;
  final int qty;
  final int price;
  final Timestamp time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.white,
        ),
        child: ListTile(
          title: Text(name,
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade900)),
          subtitle: RichText(
            text: TextSpan(
              children: <InlineSpan>[
                TextSpan(
                    text: "₹ ${price.toString()}",
                    style: const TextStyle(color: Colors.black54)),
                TextSpan(
                    text: "\t\t\t•\t\t\t",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black87)),
                TextSpan(
                    text: "${qty.toString()} unit",
                    style: const TextStyle(color: Colors.black54)),
              ],
            ),
          ),
          trailing: RichText(
            textAlign: TextAlign.right,
            text: TextSpan(
              style: const TextStyle(color: Colors.black54),
              children: <InlineSpan>[
                TextSpan(text: "${time.toDate().day}/"),
                TextSpan(text: "${time.toDate().month}/"),
                TextSpan(text: "${time.toDate().year}\n"),
                TextSpan(text: "${time.toDate().hour}:"),
                TextSpan(text: "${time.toDate().minute} Hrs."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
