import 'package:flutter/material.dart';

ShapeBorder appBarShapeBorder(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: const Radius.circular(25.0),
      topRight: const Radius.circular(25.0),
      bottomLeft: Radius.elliptical(width, 40.0),
      bottomRight: Radius.elliptical(width, 40.0),
    ),
  );
}

InputDecoration searchInput() {
  return InputDecoration(
    contentPadding: const EdgeInsets.all(12.0),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40.0), borderSide: BorderSide.none),
    focusColor: Colors.white,
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40.0), borderSide: BorderSide.none),
    filled: true,
    fillColor: Colors.white,
    labelText: 'Search',
    labelStyle: TextStyle(color: Colors.blue.shade400, fontSize: 18.0),
    floatingLabelBehavior: FloatingLabelBehavior.never,
  );
}

InputDecoration authInputDecoration() {
  return InputDecoration(
    floatingLabelBehavior: FloatingLabelBehavior.never,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide(
        color: Colors.greenAccent,
        width: 2.0,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: Colors.redAccent,
        width: 2.0,
      ),
    ),
  );
}

InputDecoration profileInputDecoration() {
  return InputDecoration(
    contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(15.0)),
  );
}

ButtonStyle authButtonStyle() {
  return ButtonStyle(
    fixedSize: MaterialStateProperty.all<Size>(Size(80, 40)),
    shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
  );
}

ButtonStyle signInMethodButtonStyle() {
  return ButtonStyle(
      fixedSize: MaterialStateProperty.all<Size>(Size.square(60.0)),
      shape: MaterialStateProperty.all<OutlinedBorder>(CircleBorder()));
}
