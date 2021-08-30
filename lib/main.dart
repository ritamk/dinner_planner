import 'package:dinner_planner/models/user.dart';
import 'package:dinner_planner/pages/authentication/auth.dart';
import 'package:dinner_planner/pages/home/home.dart';
import 'package:dinner_planner/pages/item/item_detail.dart';
import 'package:dinner_planner/pages/orders/orders.dart';
import 'package:dinner_planner/pages/profile/profile.dart';
import 'package:dinner_planner/pages/settings/setting.dart';
import 'package:dinner_planner/services/authentication.dart';
import 'package:dinner_planner/services/order_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context) => OrderListProvider(), child: MyApp()));
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
        "/": (context) => MultiProvider(providers: <SingleChildWidget>[
              StreamProvider<UserID?>.value(
                  value: AuthenticationService().user, initialData: null),
            ], child: Home()),
        "/auth": (context) => Auth(),
        "/item": (context) => ItemDetail(),
        "/settings": (context) => const Setting(),
        "/orders": (context) => const Orders(),
        "/profile": (context) => const Profile(),
      },
    );
  }
}
