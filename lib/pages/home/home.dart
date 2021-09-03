import 'package:dinner_planner/models/food.dart';
import 'package:dinner_planner/pages/home/drawer.dart';
import 'package:dinner_planner/pages/food_list/food_list.dart';
import 'package:dinner_planner/pages/home/search_field.dart';
import 'package:dinner_planner/services/database.dart';
import 'package:dinner_planner/services/order_list_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

ValueNotifier<int> filterIndex = ValueNotifier(0);
List<String> selectedFilter = [
  "All",
  "Starters",
  "Soups",
  "Salads",
];

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // GestureDetector(
        //   onTap: () {
        //     try {
        //       FocusScope.of(context).unfocus();
        //     } catch (e) {
        //       return null;
        //     }
        //   },
        // child:
        Scaffold(
      appBar: AppBar(
        toolbarHeight: 140.0,
        // shape: appBarShapeBorder(context),
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(Icons.menu, color: Colors.blue),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
        title: SearchField(),
        centerTitle: false,
        actions: <Widget>[
          Tooltip(
            message: 'Cart',
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/cart");
              },
              icon: Consumer<OrderListProvider>(
                  builder: (context, provider, child) {
                return Stack(
                  alignment: Alignment.topRight,
                  children: <Widget>[
                    Icon(Icons.shopping_cart, color: Colors.blue),
                    provider.orderList.isEmpty
                        ? const Padding(padding: EdgeInsets.all(0.0))
                        : Stack(
                            alignment: Alignment.center,
                            children: <Icon>[
                              Icon(Icons.circle,
                                  color: Colors.white, size: 14.0),
                              Icon(Icons.circle,
                                  color: Colors.red[700], size: 10.0),
                            ],
                          ),
                  ],
                );
              }),
            ),
          ),
          Tooltip(
            message: 'Filter/Sort',
            child: IconButton(
                onPressed: () {}, icon: Icon(Icons.tune, color: Colors.blue)),
          ),
          const SizedBox(width: 8.0),
        ],
        bottom: PreferredSize(
            preferredSize: Size(double.infinity, 100.0),
            child: FilterToggleButtonWidget()),
      ),
      body: StreamProvider<List<Food>>.value(
        value: DatabaseService().food,
        initialData: [],
        child: ValueListenableBuilder(
          valueListenable: filterIndex,
          builder: (BuildContext context, int index, Widget? child) {
            return FoodList(filter: selectedFilter[index]);
          },
        ),
      ),
      drawer: HomeDrawer(
        loginWidget: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
          leading: Icon(Icons.login_rounded),
          title: Text("Log In", style: TextStyle(fontSize: 16.0)),
          trailing: Icon(Icons.arrow_right),
          onTap: () => Navigator.pushNamed(context, "/auth"),
        ),
      ),
    );
  }
}

class FilterToggleButtonWidget extends StatefulWidget {
  const FilterToggleButtonWidget({Key? key}) : super(key: key);

  @override
  _FilterToggleButtonWidgetState createState() =>
      _FilterToggleButtonWidgetState();
}

class _FilterToggleButtonWidgetState extends State<FilterToggleButtonWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: selectedFilter.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorSize: TabBarIndicatorSize.label,
      onTap: (index) {
        setState(() {
          filterIndex.value = index;
        });
      },
      isScrollable: true,
      controller: _tabController,
      indicatorColor: Colors.transparent,
      tabs: <Widget>[
        tabs(0, filterIndex.value),
        tabs(1, filterIndex.value),
        tabs(2, filterIndex.value),
        tabs(3, filterIndex.value),
      ],
    );
  }

  Container tabs(int index, int selected) {
    return Container(
      constraints: BoxConstraints(maxHeight: 100.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: selected == index ? Colors.blue : Colors.blue.shade50,
          borderRadius: BorderRadius.circular(25.0)),
      child: Text(selectedFilter[index],
          style: TextStyle(
              color: selected == index ? Colors.white : Colors.blue,
              fontSize: 18.0,
              fontWeight: FontWeight.bold)),
    );
  }
}
