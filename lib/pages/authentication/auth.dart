import 'package:dinner_planner/pages/authentication/sign_in.dart';
import 'package:dinner_planner/pages/authentication/sign_in_method.dart';
import 'package:dinner_planner/pages/authentication/sign_up.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  Auth({Key? key}) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  int pageIndex = 0;
  late PageController pageController;
  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    pages = [
      SignIn(),
      SignUp(),
      SignInAnonymously(),
    ];
    pageController = PageController(initialPage: pageIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white10,
          leading: IconButton(
            onPressed: () => Navigator.pop(context, "/"),
            icon: const Icon(
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
                selectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.bold),
                selectedFontSize: 18.0,
                unselectedFontSize: 15.0,
                currentIndex: pageIndex,
                onTap: onTabTapped,
                elevation: 0.0,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    label: "Sign In",
                    icon: const Icon(Icons.person_outline),
                  ),
                  BottomNavigationBarItem(
                    label: "Sign Up",
                    icon: const Icon(Icons.person_add_alt),
                  ),
                  BottomNavigationBarItem(
                    label: "Others",
                    icon: const Icon(Icons.face_outlined),
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
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }
}
