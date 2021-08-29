import 'package:dinner_planner/services/authentication.dart';
import 'package:dinner_planner/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInAnonymously extends StatefulWidget {
  const SignInAnonymously({Key? key}) : super(key: key);

  @override
  _SignInAnonymouslyState createState() => _SignInAnonymouslyState();
}

class _SignInAnonymouslyState extends State<SignInAnonymously> {
  bool loading = false;
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextButton(
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    dynamic result =
                        await AuthenticationService().signInAnonymously();
                    result == null
                        ? setState(() {
                            loading = false;
                            error =
                                "There was an error. Check the network connection.";
                          })
                        : Navigator.pop(context, "/");
                  },
                  child: Text(
                    "Sign In Anonymously",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  style: authButtonStyle().copyWith(
                    fixedSize:
                        MaterialStateProperty.all<Size>(Size(180.0, 40.0)),
                  ),
                ),
                const SizedBox(height: 25.0),
                Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    Container(
                      child: Text(
                        error,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
