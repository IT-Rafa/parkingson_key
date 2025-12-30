import 'package:flutter_riverpod/legacy.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_layout.dart';
import 'package:parkingson_key/src/models/keyboard_Layouts/es_consonants_vowels_keyboard_layout.dart';

final keyboardLayoutProvider =
    StateProvider<KeyboardLayout>((_) => esConsonantsVowelsKeyboardLayout);
