import 'package:dinner_planner/models/food.dart';
import 'package:dinner_planner/pages/home/drawer.dart';
import 'package:dinner_planner/pages/food_list/food_list.dart';
import 'package:dinner_planner/pages/home/search_field.dart';
import 'package:dinner_planner/services/database.dart';
import 'package:dinner_planner/shared/constants.dart';
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
          toolbarHeight: 150.0,
          shape: appBarShapeBorder(),
          elevation: 0.0,
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu, color: Colors.white),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          }),
          title: SearchField(),
          actions: <Widget>[
            Tooltip(
              message: 'Cart',
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/orders");
                },
                icon: Icon(Icons.shopping_cart),
              ),
            ),
            Tooltip(
              message: 'Filter/Sort',
              child: IconButton(onPressed: () {}, icon: Icon(Icons.tune)),
            ),
            const SizedBox(width: 8.0),
          ],
          bottom: PreferredSize(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: const FilterToggleButtonWidget(),
                  ),
                ],
              ),
            ),
            preferredSize: Size.fromHeight(80.0),
          ),
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
            onTap: () => Navigator.of(context).pushNamed("/auth"),
          ),
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

class _FilterToggleButtonWidgetState extends State<FilterToggleButtonWidget> {
  List<bool> selectedIndex = [];
  Color noColor = Colors.black.withAlpha(0);

  @override
  void initState() {
    super.initState();
    selectedIndex = [
      true,
      false,
      false,
      false,
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      borderColor: noColor,
      selectedBorderColor: noColor,
      splashColor: noColor,
      children: [
        filterContainerWidget(selectedFilter[0], selectedIndex[0]),
        filterContainerWidget(selectedFilter[1], selectedIndex[1]),
        filterContainerWidget(selectedFilter[2], selectedIndex[2]),
        filterContainerWidget(selectedFilter[3], selectedIndex[3]),
      ],
      isSelected: selectedIndex,
      onPressed: (index) {
        setState(() {
          for (int i = 0; i < selectedIndex.length; i++) {
            selectedIndex[i] = i == index;
            filterIndex.value = index;
          }
        });
      },
    );
  }

  Widget filterContainerWidget(String name, bool selected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: selected ? Colors.white30 : Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(name,
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: selected ? Colors.white : Colors.black54),
              textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
