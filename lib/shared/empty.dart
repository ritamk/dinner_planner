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
            const Icon(Icons.remove_shopping_cart,
                color: Colors.blue, size: 25.0),
            const SizedBox(height: 40.0),
            const Flexible(
              child: Text(
                "Wow, didn't expect this to be so empty.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 15.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyBody extends StatelessWidget {
  const EmptyBody({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.error, color: Colors.blue, size: 25.0),
          const SizedBox(height: 40.0),
          Flexible(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue, fontSize: 15.0),
            ),
          ),
        ],
      ),
    );
  }
}
