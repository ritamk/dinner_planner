import 'package:dinner_planner/models/user.dart';
import 'package:dinner_planner/shared/not_logged_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserID? userID = Provider.of<UserID?>(context);

    return userID != null
        ? Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Navigator.pop(context, "/"),
                icon: Icon(Icons.arrow_back_ios),
              ),
              title: Text("Profile", style: TextStyle(color: Colors.blue)),
            ),
          )
        : NotLoggedIn();
  }
}
