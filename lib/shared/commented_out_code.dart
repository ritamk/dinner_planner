
// PreferredSize(
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: const FilterToggleButtonWidget(),
//                   ),
//                 ],
//               ),
//             ),
//             preferredSize: Size.fromHeight(20.0),
//           ),

// class FilterToggleButtonWidget extends StatefulWidget {
//   const FilterToggleButtonWidget({Key? key}) : super(key: key);

//   @override
//   _FilterToggleButtonWidgetState createState() =>
//       _FilterToggleButtonWidgetState();
// }

// class _FilterToggleButtonWidgetState extends State<FilterToggleButtonWidget> {
//   List<bool> selectedIndex = [];
//   Color noColor = Colors.black.withAlpha(0);

//   @override
//   void initState() {
//     super.initState();
//     selectedIndex = [
//       true,
//       false,
//       false,
//       false,
//     ];
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ToggleButtons(
//       borderColor: noColor,
//       selectedBorderColor: noColor,
//       splashColor: noColor,
//       children: [
//         filterContainerWidget(selectedFilter[0], selectedIndex[0]),
//         filterContainerWidget(selectedFilter[1], selectedIndex[1]),
//         filterContainerWidget(selectedFilter[2], selectedIndex[2]),
//         filterContainerWidget(selectedFilter[3], selectedIndex[3]),
//       ],
//       isSelected: selectedIndex,
//       onPressed: (index) {
//         setState(() {
//           for (int i = 0; i < selectedIndex.length; i++) {
//             selectedIndex[i] = i == index;
//             filterIndex.value = index;
//           }
//         });
//       },
//     );
//   }

//   Widget filterContainerWidget(String name, bool selected) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: Container(
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(30.0),
//           color: selected ? Colors.white30 : Colors.white,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//           child: Text(name,
//               style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                   color: selected ? Colors.white : Colors.black54),
//               textAlign: TextAlign.center),
//         ),
//       ),
//     );
//   }
// }
