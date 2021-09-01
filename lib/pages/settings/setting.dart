import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context, "/"),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text("Settings", style: TextStyle(color: Colors.blue)),
      ),
    );
  }
}
