import 'package:parkingson_key/src/models/keyboard/keyboard_item.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_layout.dart';

final enNumbersKeyboardLayout = KeyboardLayout(
  id: 'en_numbers',
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
      KeyboardItem.char('6'),
      KeyboardItem.char('7'),
      KeyboardItem.char('8'),
      KeyboardItem.char('9'),
      KeyboardItem.char('0'),
    ],
    [
      KeyboardItem.action(title: 'KEYBOARD_back'),
    ],
  ],
);
