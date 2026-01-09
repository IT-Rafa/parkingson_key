import 'dart:io';

import 'package:vibration/vibration.dart';

class HapticFeedbackService {
  static Future<void> tap() async {
    if (Platform.isAndroid || Platform.isIOS) {
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(duration: 40);
      }
    }
  }
}
