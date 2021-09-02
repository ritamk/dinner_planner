import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField>
    with SingleTickerProviderStateMixin {
  final FocusNode _focusNode = FocusNode();
  bool isOpen = false;
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween<double>(begin: 50, end: 700).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: 50.0,
          width: _animation.value,
          constraints: BoxConstraints(maxWidth: double.maxFinite),
          child: TextFormField(
            focusNode: _focusNode,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
              fillColor: Colors.blue,
              filled: true,
              hintText: "Search",
              hintStyle: TextStyle(fontSize: 18.0, color: Colors.white),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  borderSide: BorderSide.none),
              prefixIcon: IconButton(
                tooltip: "Search",
                onPressed: () {
                  setState(() {
                    if (isOpen) {
                      _animationController.reverse();
                      _focusNode.unfocus();
                    } else {
                      _animationController.forward();
                      _focusNode.requestFocus();
                    }
                    this.isOpen = !isOpen;
                  });
                },
                icon: isOpen
                    ? Icon(Icons.close, color: Colors.white)
                    : Icon(Icons.search, color: Colors.white),
              ),
            ),
            style: TextStyle(fontSize: 18.0, color: Colors.white),
            textInputAction: TextInputAction.search,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
