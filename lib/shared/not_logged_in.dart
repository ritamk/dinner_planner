import 'package:flutter/material.dart';

class NotLoggedIn extends StatelessWidget {
  const NotLoggedIn({Key? key}) : super(key: key);

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
            const Icon(Icons.person_off, color: Colors.blue, size: 25.0),
            const SizedBox(height: 40.0),
            const Flexible(
              child: Text(
                "Why leave this empty when you can log-in?",
                style: TextStyle(color: Colors.blue, fontSize: 15.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
