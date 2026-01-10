import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_item.dart';

class KeyboardRepeatController {
  KeyboardItem? _lastItem;
  DateTime? _lastAcceptedAt;

  bool canAccept(
    KeyboardItem item,
    Duration blockDuration,
  ) {
    final now = DateTime.now();

    if (_lastItem == item &&
        _lastAcceptedAt != null &&
        now.difference(_lastAcceptedAt!) < blockDuration) {
      return false;
    }

    _lastItem = item;
    _lastAcceptedAt = now;
    return true;
  }

  void reset() {
    _lastItem = null;
    _lastAcceptedAt = null;
  }
}
