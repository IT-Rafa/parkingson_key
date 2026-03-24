import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_type_enum.dart';

final keyboardTypeProvider =
    NotifierProvider<KeyboardTypeController, KeyboardType>(
  KeyboardTypeController.new,
);

final keyboardLastTypeProvider = StateProvider<KeyboardType?>((_) => null);

class KeyboardTypeController extends Notifier<KeyboardType> {
  @override
  KeyboardType build() {
    return KeyboardType.consonantsVowels; // default
  }

  void setType(KeyboardType type) {
    state = type;
  }
}