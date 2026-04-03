import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/widgets/keyboard_item.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_layout.dart';

final esNumbersKeyboardLayout = KeyboardLayout(
  id: 'es_numbers',
  portrait: [
    [KeyboardItem.char('1'), KeyboardItem.char('2'), KeyboardItem.char('3')],
    [KeyboardItem.char('4'), KeyboardItem.char('5'), KeyboardItem.char('6')],
    [KeyboardItem.char('7'), KeyboardItem.char('8'), KeyboardItem.char('9')],
    [
      KeyboardItem.char('0'),
      KeyboardItem.char('.'),
      KeyboardItem.char(','),
      KeyboardItem.char(':'),
    ],
    [
      KeyboardItem.action(title: 'KEYBOARD_back'),
    ],
  ],
  landscape: [
    [
      KeyboardItem.char('1'),
      KeyboardItem.char('2'),
      KeyboardItem.char('3'),
      KeyboardItem.char('4'),
      KeyboardItem.char('5'),
    ],
    [
      KeyboardItem.char('6'),
      KeyboardItem.char('7'),
      KeyboardItem.char('8'),
      KeyboardItem.char('9'),
      KeyboardItem.char('0'),
    ],
    [
      KeyboardItem.char('.'),
      KeyboardItem.char(','),
      KeyboardItem.char(':'),
    ],
    [
      KeyboardItem.action(title: 'KEYBOARD_back'),
    ],
  ],
);
