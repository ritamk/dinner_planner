import 'package:dinner_planner/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogToLogin extends StatelessWidget {
  const DialogToLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.error,
              color: Colors.red.shade700,
              size: 24.0,
            ),
            const SizedBox(height: 20.0),
            Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Flexible(
                  child: Text(
                    "Please log-in to use the add-to-cart function",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 16.0, color: Colors.red.shade700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  Navigator.pushNamed(context, "/auth");
                },
                child: const Text("Log In",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold)),
                style: authButtonStyle()),
          ],
        ),
      ),
    );
  }
}
