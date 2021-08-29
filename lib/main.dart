import 'package:dinner_planner/models/user.dart';
import 'package:dinner_planner/pages/authentication/auth.dart';
import 'package:dinner_planner/pages/home/home.dart';
import 'package:dinner_planner/pages/item/item_detail.dart';
import 'package:dinner_planner/pages/orders/orders.dart';
import 'package:dinner_planner/pages/profile/profile.dart';
import 'package:dinner_planner/pages/settings/setting.dart';
import 'package:dinner_planner/services/authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => StreamProvider<UserID?>.value(
            value: AuthenticationService().user,
            initialData: null,
            child: Home()),
        "/home": (context) => Home(),
        "/auth": (context) => Auth(),
        "/item": (context) => ItemDetail(),
        "/settings": (context) => const Setting(),
        "/order": (context) => const Orders(),
        "/profile": (context) => const Profile(),
      },
    );
  }
}
