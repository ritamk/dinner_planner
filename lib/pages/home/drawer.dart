import 'package:dinner_planner/models/user.dart';
import 'package:dinner_planner/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:dinner_planner/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserID? userID = Provider.of<UserID?>(context);
    const EdgeInsetsGeometry _contentPadding =
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0);
    const TextStyle _titleStyle = TextStyle(fontSize: 16.0);

    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                StreamBuilder<UserData>(
                    stream: DatabaseService(uid: userID?.uid ?? null).userData,
                    builder: (context, snapshot) {
                      final String name = snapshot.data?.name ?? "there";
                      final String pic = snapshot.data?.userPic ?? "";
                      return DrawerHeaderWidget(name: name, pic: pic);
                    }),
                ListTile(
                  contentPadding: _contentPadding,
                  leading: const Icon(Icons.person),
                  title: const Text("Profile", style: _titleStyle),
                  trailing: const Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.pushNamed(context, "/profile");
                  },
                ),
                ListTile(
                  contentPadding: _contentPadding,
                  leading: const Icon(Icons.shopping_bag),
                  title: const Text("Active Orders", style: _titleStyle),
                  trailing: const Icon(Icons.arrow_right),
                  onTap: () => Navigator.pushNamed(context, "/orders"),
                ),
              ],
            ),
          ),
          Container(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Column(
                  children: <Widget>[
                    const Divider(),
                    ListTile(
                      contentPadding: _contentPadding,
                      leading: const Icon(Icons.settings),
                      title: const Text("Settings", style: _titleStyle),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: () {
                        Navigator.pushNamed(context, "/settings");
                      },
                    ),
                    userID != null
                        ? ListTile(
                            contentPadding: _contentPadding,
                            leading: const Icon(Icons.logout_rounded),
                            title: const Text("Log Out", style: _titleStyle),
                            trailing: const Icon(Icons.arrow_right),
                            onTap: () {
                              AuthenticationService().signOut();
                            },
                          )
                        : ListTile(
                            contentPadding: _contentPadding,
                            leading: const Icon(Icons.login_rounded),
                            title: const Text("Log In", style: _titleStyle),
                            trailing: const Icon(Icons.arrow_right),
                            onTap: () => Navigator.pushNamed(context, "/auth"),
                          ),
                    ListTile(
                      contentPadding: _contentPadding,
                      leading: const Icon(Icons.power_settings_new_rounded),
                      title: const Text("Exit", style: _titleStyle),
                      trailing: const Icon(Icons.arrow_right),
                      onTap: () => SystemNavigator.pop(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({Key? key, required this.name, required this.pic})
      : super(key: key);
  final String name;
  final String pic;

  @override
  Widget build(BuildContext context) {
    final CircleAvatar image =
        CircleAvatar(radius: 35.0, foregroundImage: NetworkImage(pic));
    final String userName = name;
    return DrawerHeader(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.blueAccent.shade400,
                  blurRadius: 12.0,
                  offset: const Offset(0, 3.5),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                const CircleAvatar(
                  radius: 40.0,
                ),
                pic.isEmpty
                    ? const Icon(Icons.face, size: 80.0, color: Colors.white)
                    : image,
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            "Hey $userName!",
            style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
