import 'package:dinner_planner/services/filter_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterListProvider>(builder: (context, provider, child) {
      return TabBar(
        enableFeedback: false,
        onTap: (index) {
          setState(() {
            provider.filterChange(index);
          });
        },
        isScrollable: true,
        controller: _tabController,
        tabs: <Widget>[
          TabsWidget(index: 0, selected: provider.filterIndex),
          TabsWidget(index: 1, selected: provider.filterIndex),
          TabsWidget(index: 2, selected: provider.filterIndex),
          TabsWidget(index: 3, selected: provider.filterIndex),
          TabsWidget(index: 4, selected: provider.filterIndex),
        ],
      );
    });
  }
}

class TabsWidget extends StatelessWidget {
  const TabsWidget({Key? key, required this.index, required this.selected})
      : super(key: key);
  final int index;
  final int selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 100.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      decoration: BoxDecoration(
          color: selected == index ? Colors.blue : Colors.blue.shade50,
          borderRadius: BorderRadius.circular(30.0)),
      child: Consumer<FilterListProvider>(
        builder: (context, provider, child) {
          return Text(
            provider.filterList[index],
            style: TextStyle(
                color: selected == index ? Colors.white : Colors.blue),
          );
        },
      ),
    );
  }
}
