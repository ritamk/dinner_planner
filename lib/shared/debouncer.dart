import 'dart:async';

import 'package:flutter/cupertino.dart';

class Debouncer {
  final int milliseconds;
  VoidCallback? voidCallback;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
