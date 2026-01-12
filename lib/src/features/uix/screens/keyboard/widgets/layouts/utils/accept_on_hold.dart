import 'dart:async';
import 'package:flutter/services.dart';

class AcceptOnHold {
  Timer? _timer;



  void start({
    required VoidCallback onAccept,
    required Duration duration,
  }) {
    cancel();
    _timer = Timer(duration, onAccept);
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() => cancel();
}
