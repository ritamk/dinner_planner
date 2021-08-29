import 'package:dinner_planner/models/user.dart';
import 'package:dinner_planner/pages/authentication/sign_in.dart';
import 'package:dinner_planner/pages/authentication/sign_in_method.dart';
import 'package:dinner_planner/pages/authentication/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Auth extends StatefulWidget {
  Auth({Key? key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  var pageIndex = 0;
  late PageController pageController = PageController(initialPage: pageIndex);
  List<Widget> pages = [SignIn(), SignUp(), SignInAnonymously()];

  @override
  Widget build(BuildContext context) {
    final UserID? user = Provider.of<UserID?>(context);
    return GestureDetector(
      onTap: () {
        try {
          FocusScope.of(context).unfocus();
        } catch (e) {
          return null;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white10,
          leading: IconButton(
            onPressed: () => Navigator.pop(context, "/"),
            icon: Icon(
              Icons.home,
              color: Colors.blue,
            ),
          ),
        ),
        body: PageView(
            children: pages,
            controller: pageController,
            onPageChanged: onPageChanged),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: BottomNavigationBar(
                selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                selectedFontSize: 18.0,
                unselectedFontSize: 15.0,
                currentIndex: pageIndex,
                onTap: onTabTapped,
                elevation: 0.0,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    label: "Sign In",
                    icon: Icon(Icons.person_outline),
                  ),
                  BottomNavigationBarItem(
                    label: "Sign Up",
                    icon: Icon(Icons.person_add_alt),
                  ),
                  BottomNavigationBarItem(
                    label: "Sign In Methods",
                    icon: Icon(Icons.face_outlined),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onPageChanged(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  void onTabTapped(int index) {
    setState(() {
      pageIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }
}
