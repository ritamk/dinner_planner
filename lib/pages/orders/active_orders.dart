import 'package:dinner_planner/models/order.dart';
import 'package:dinner_planner/models/user.dart';
import 'package:dinner_planner/pages/orders/order_tile.dart';
import 'package:dinner_planner/services/database.dart';
import 'package:dinner_planner/services/order_list_provider.dart';
import 'package:dinner_planner/shared/empty.dart';
import 'package:dinner_planner/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    final UserID? userID = Provider.of<UserID?>(context);

    return Consumer<OrderListProvider>(builder: (context, provider, child) {
      return userID != null
          ? Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () =>
                      Navigator.popUntil(context, ModalRoute.withName("/")),
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                title: const Text("Active Orders"),
              ),
              body: FutureBuilder<List<FetchOrderData>>(
                future: DatabaseService(uid: userID.uid).userActiveOrder,
                initialData: [],
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data.isNotEmpty
                        ? RefreshIndicator(
                            onRefresh: () async => setState(() {}),
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return OrderTile(
                                    name: snapshot.data[index].name,
                                    qty: snapshot.data[index].qty,
                                    price: snapshot.data[index].price,
                                    time: snapshot.data[index].time);
                              },
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                            ),
                          )
                        : const EmptyBody(
                            message: "Wow, didn't expect this to be so empty.");
                  } else {
                    return const Loading();
                  }
                },
              ),
            )
          : const EmptyPage();
    });
  }
}
