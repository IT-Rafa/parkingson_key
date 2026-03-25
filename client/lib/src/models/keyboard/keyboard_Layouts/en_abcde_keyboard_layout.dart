import 'package:parkingson_key/src/models/keyboard/keyboard_item.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_layout.dart';

final enAbcdeKeyboardLayout = KeyboardLayout(
  id: 'en_abcde',
  portrait: [
    [
      KeyboardItem.char('a'),
      KeyboardItem.char('b'),
      KeyboardItem.char('c'),
      KeyboardItem.char('d'),
      KeyboardItem.char('e'),
    ],
    [
      KeyboardItem.char('f'),
      KeyboardItem.char('g'),
      KeyboardItem.char('h'),
      KeyboardItem.char('i'),
      KeyboardItem.char('j'),
    ],
    [
      KeyboardItem.char('k'),
      KeyboardItem.char('l'),
      KeyboardItem.char('m'),
      KeyboardItem.char('n'),
    ],
    [
      KeyboardItem.char('o'),
      KeyboardItem.char('p'),
      KeyboardItem.char('q'),
      KeyboardItem.char('r'),
      KeyboardItem.char('s'),
    ],
    [
      KeyboardItem.char('t'),
      KeyboardItem.char('u'),
      KeyboardItem.char('v'),
      KeyboardItem.char('w'),
      KeyboardItem.char('x'),
    ],
    [
      KeyboardItem.char('y'),
      KeyboardItem.char('z'),
    ],
    [
      KeyboardItem.char('Yes'),
      KeyboardItem.char('No'),
      KeyboardItem.char('  '),
    ],
    [
      KeyboardItem.action(
        title: 'KEYBOARD_symbols',
      ),
      KeyboardItem.action(
        title: 'KEYBOARD_numbers',
      ),
    ],
  ],
  landscape: [
    [
      KeyboardItem.char('a'),
      KeyboardItem.char('b'),
      KeyboardItem.char('c'),
      KeyboardItem.char('d'),
      KeyboardItem.char('e'),
      KeyboardItem.char('f'),
      KeyboardItem.char('g'),
      KeyboardItem.char('h'),
    ],
    [
      KeyboardItem.char('i'),
      KeyboardItem.char('j'),
      KeyboardItem.char('k'),
      KeyboardItem.char('l'),
      KeyboardItem.char('m'),
      KeyboardItem.char('n'),
      KeyboardItem.char('o'),
      KeyboardItem.char('p'),
    ],
    [
      KeyboardItem.char('q'),
      KeyboardItem.char('r'),
      KeyboardItem.char('s'),
      KeyboardItem.char('t'),
      KeyboardItem.char('u'),
      KeyboardItem.char('v'),
    ],
    [
      KeyboardItem.char('w'),
      KeyboardItem.char('x'),
      KeyboardItem.char('y'),
      KeyboardItem.char('z'),
    ],
    [
      KeyboardItem.char('Yes'),
      KeyboardItem.char('No'),
      KeyboardItem.char('  '),
    ],
    [
      KeyboardItem.action(
        title: 'KEYBOARD_symbols',
      ),
      KeyboardItem.action(
        title: 'KEYBOARD_numbers',
      ),
    ],
  ],
);
