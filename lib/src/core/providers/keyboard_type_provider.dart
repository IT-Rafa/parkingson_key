import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/models/keyboard_type.dart';

final keyboardTypeProvider =
    NotifierProvider<KeyboardTypeController, KeyboardType>(
  KeyboardTypeController.new,
);

class KeyboardTypeController extends Notifier<KeyboardType> {
  @override
  KeyboardType build() {
    return KeyboardType.qwerty; // default
  }

  void setType(KeyboardType type) {
    state = type;
  }
}