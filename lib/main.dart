import 'package:dinner_planner/models/user.dart';
import 'package:dinner_planner/pages/authentication/auth.dart';
import 'package:dinner_planner/pages/orders/cart.dart';
import 'package:dinner_planner/pages/home/home.dart';
import 'package:dinner_planner/pages/orders/active_orders.dart';
import 'package:dinner_planner/pages/profile/profile.dart';
import 'package:dinner_planner/pages/settings/setting.dart';
import 'package:dinner_planner/services/authentication.dart';
import 'package:dinner_planner/services/filter_list_provider.dart';
import 'package:dinner_planner/services/food_list_provider.dart';
import 'package:dinner_planner/services/order_list_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: <SingleChildWidget>[
    StreamProvider<UserID?>.value(
        value: AuthenticationService().user, initialData: null),
    ChangeNotifierProvider(create: (context) => OrderListProvider()),
    ChangeNotifierProvider(create: (context) => FilterListProvider()),
    ChangeNotifierProvider(create: (context) => FoodListProvider())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant',
      theme: mainTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const Home(),
        "/auth": (context) => Auth(),
        "/cart": (context) => const Cart(),
        "/settings": (context) => const Setting(),
        "/orders": (context) => const Orders(),
        "/profile": (context) => const Profile(),
      },
    );
  }
}

ThemeData mainTheme() {
  return ThemeData(
    fontFamily: "Montserrat",
    tabBarTheme: const TabBarTheme(
      labelStyle: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: "Montserrat"),
      unselectedLabelStyle: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: "Montserrat"),
      indicatorSize: TabBarIndicatorSize.label,
      indicator: const BoxDecoration(color: Colors.transparent),
    ),
    appBarTheme: const AppBarTheme(
        elevation: 0.0,
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: Colors.blue, fontSize: 20.0, fontFamily: "Montserrat"),
        backgroundColor: Colors.white24,
        iconTheme: const IconThemeData(color: Colors.blue)),
    primarySwatch: Colors.blue,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
  );
}
