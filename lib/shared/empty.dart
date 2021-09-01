import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () => Navigator.pop(context, "/"),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.production_quantity_limits,
                color: Colors.blue, size: 25.0),
            const SizedBox(height: 40.0),
            const Flexible(
              child: Text(
                "C'mon, don't leave this empty.",
                style: TextStyle(color: Colors.blue, fontSize: 15.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
