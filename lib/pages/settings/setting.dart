import 'package:dinner_planner/models/food.dart';
import 'package:dinner_planner/services/database.dart';
import 'package:dinner_planner/shared/loading.dart';
import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context, "/"),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Settings"),
      ),
    );
  }
}
