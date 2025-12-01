import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/keyboard_layout_model.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/key_item.dart';

final defaultKeyboard = KeyboardLayoutModel(
  id: 'default',
  name: 'Teclado Español',
  rows: [
    [
      KeyItem('B', 1), KeyItem('C', 1), KeyItem('D', 1),
      KeyItem('F', 1), KeyItem('G', 1), KeyItem('H', 1),
    ],
    [KeyItem('J', 1), KeyItem('K', 1), KeyItem('L', 1), KeyItem('LL', 2)],
    [
      KeyItem('M', 1), KeyItem('N', 1), KeyItem('Ñ', 1),
      KeyItem('P', 1), KeyItem('Q', 1), KeyItem('QU', 2),
    ],
    [KeyItem('R', 1), KeyItem('RR', 2), KeyItem('S', 1), KeyItem('T', 1)],
    [
      KeyItem('V', 1), KeyItem('W', 1), KeyItem('X', 1),
      KeyItem('Y', 1), KeyItem('Z', 1),
    ],
    [
      KeyItem('A', 1), KeyItem('E', 1), KeyItem('I', 1),
      KeyItem('O', 1), KeyItem('U', 1), KeyItem('Space', 2),
    ],
  ],
);

final keyboardProvider = Provider.autoDispose((ref) => defaultKeyboard);



