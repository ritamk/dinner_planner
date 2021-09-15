import 'package:dinner_planner/services/food_list_provider.dart';
import 'package:dinner_planner/shared/debouncer.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({Key? key, required this.foodListProvider})
      : super(key: key);
  final FoodListProvider foodListProvider;

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField>
    with SingleTickerProviderStateMixin {
  final FocusNode _focusNode = FocusNode();
  late TextEditingController _textController;
  late AnimationController _animationController;
  late Animation _animation;
  final Debouncer _debouncer = Debouncer(milliseconds: 800);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween<double>(begin: 50.0, end: 700.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: 50.0,
          width: _animation.value,
          constraints: const BoxConstraints(maxWidth: double.maxFinite),
          child: TextFormField(
            controller: _textController,
            cursorColor: Colors.white,
            focusNode: _focusNode,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
              fillColor: Colors.blue,
              filled: true,
              hintText: "Search",
              hintStyle: const TextStyle(fontSize: 18.0, color: Colors.white),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none),
              prefixIcon: IconButton(
                tooltip: "Search",
                onPressed: () {
                  widget.foodListProvider.openClose();
                  if (widget.foodListProvider.isSearching) {
                    setState(() {
                      _animationController.forward();
                    });
                    _focusNode.requestFocus();
                  } else {
                    setState(() {
                      _animationController.reverse();
                    });
                    widget.foodListProvider.searchClear();
                    if (_focusNode.hasFocus) {
                      _focusNode.unfocus();
                    }
                    _textController.clear();
                  }
                },
                icon: widget.foodListProvider.isSearching
                    ? const Icon(Icons.close, color: Colors.white)
                    : const Icon(Icons.search, color: Colors.white),
              ),
            ),
            style: const TextStyle(fontSize: 18.0, color: Colors.white),
            textInputAction: TextInputAction.search,
            onChanged: (val) => _debouncer.run(
                () => widget.foodListProvider.searchFood(val.toLowerCase())),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
