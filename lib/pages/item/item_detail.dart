import 'package:flutter/material.dart';

class ItemDetail extends StatelessWidget {
  const ItemDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context, "/"),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text("Item Detail"),
      ),
    );
  }
}
