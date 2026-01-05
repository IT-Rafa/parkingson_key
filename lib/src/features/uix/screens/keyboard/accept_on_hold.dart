import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

class AcceptOnHold {
  Timer? _timer;

  void start({
    required VoidCallback onAccept,
    Duration duration = const Duration(milliseconds: 500),
    bool haptic = true,
  }) {
    cancel();
    _timer = Timer(duration, () async {
      if (Platform.isAndroid || Platform.isIOS) {
        if (await Vibration.hasVibrator()) {
          Vibration.vibrate(duration: 50);
        }
      }
      onAccept();
    });
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    cancel();
  }
}
