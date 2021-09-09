import 'package:dinner_planner/models/user.dart';
import 'package:dinner_planner/pages/orders/order_tile.dart';
import 'package:dinner_planner/services/database.dart';
import 'package:dinner_planner/services/order_list_provider.dart';
import 'package:dinner_planner/shared/empty.dart';
import 'package:dinner_planner/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserID? userID = Provider.of<UserID?>(context);

    return Consumer<OrderListProvider>(builder: (context, provider, child) {
      return userID != null
          ? Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () => Navigator.pop(context, "/"),
                  icon: Icon(Icons.arrow_back_ios),
                ),
                title: Text("Active Orders"),
              ),
              body: StreamBuilder(
                stream: DatabaseService(uid: userID.uid).userActiveOrder,
                initialData: [],
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data.isNotEmpty
                        ? ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              // 0 - item, 1 - price, 2 - qty, 3 - name, 4 - time
                              List<dynamic> field = snapshot.data[index].entries
                                  .map((e) => e.value)
                                  .toList();

                              return OrderTile(
                                  price: field[1],
                                  qty: field[2],
                                  name: field[3],
                                  time: field[4]);
                            },
                            physics: BouncingScrollPhysics(),
                          )
                        : EmptyBody(
                            message: "Wow, didn't expect this to be so empty.");
                  } else {
                    return Loading();
                  }
                },
              ),
            )
          : EmptyPage();
    });
  }
}
