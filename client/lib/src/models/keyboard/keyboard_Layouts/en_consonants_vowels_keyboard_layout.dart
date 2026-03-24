import 'package:parkingson_key/src/models/keyboard/keyboard_item.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_layout.dart';

final enConsonantsVowelsKeyboardLayout = KeyboardLayout(
  id: 'en_consonants_vowels',
  portrait: [
    [
      KeyboardItem.char('b'),
      KeyboardItem.char('c'),
      KeyboardItem.char('d'),
      KeyboardItem.char('f'),
      KeyboardItem.char('g'),
      KeyboardItem.char('h'),
    ],
    [
      KeyboardItem.char('j'),
      KeyboardItem.char('k'),
      KeyboardItem.char('l'),
      KeyboardItem.char('m'),
      KeyboardItem.char('n'),
      KeyboardItem.char('p'),
    ],
    [
      KeyboardItem.char('q'),
      KeyboardItem.char('r'),
      KeyboardItem.char('s'),
      KeyboardItem.char('t'),
      KeyboardItem.char('v'),
    ],
    [
      KeyboardItem.char('w'),
      KeyboardItem.char('x'),
      KeyboardItem.char('y'),
      KeyboardItem.char('z'),
    ],
    [
      KeyboardItem.char('a'),
      KeyboardItem.char('e'),
      KeyboardItem.char('i'),
      KeyboardItem.char('o'),
      KeyboardItem.char('u'),
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
      KeyboardItem.dropdown(
        title: 'KEYBOARD_numbers',
        items: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'],
      ),
      KeyboardItem.action(
        title: 'KEYBOARD_phrases',
      ),
    ],
  ],
  landscape: [
    [
      KeyboardItem.char('b'),
      KeyboardItem.char('c'),
      KeyboardItem.char('d'),
      KeyboardItem.char('f'),
      KeyboardItem.char('g'),
      KeyboardItem.char('h'),
      KeyboardItem.char('j'),
      KeyboardItem.char('k'),
    ],
    [
      KeyboardItem.char('l'),
      KeyboardItem.char('m'),
      KeyboardItem.char('n'),
      KeyboardItem.char('p'),
      KeyboardItem.char('q'),
      KeyboardItem.char('r'),
      KeyboardItem.char('s'),
    ],
    [
      KeyboardItem.char('t'),
      KeyboardItem.char('v'),
      KeyboardItem.char('w'),
      KeyboardItem.char('x'),
      KeyboardItem.char('y'),
      KeyboardItem.char('z'),
    ],
    [
      KeyboardItem.char('Yes'),
      KeyboardItem.char('No'),
      KeyboardItem.char('a'),
      KeyboardItem.char('e'),
      KeyboardItem.char('i'),
      KeyboardItem.char('o'),
      KeyboardItem.char('u'),
      KeyboardItem.char('  '),
    ],
    [
      KeyboardItem.action(
        title: 'KEYBOARD_symbols',
      ),
      KeyboardItem.dropdown(
        title: 'KEYBOARD_numbers',
        items: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'],
      ),
      KeyboardItem.action(
        title: 'KEYBOARD_phrases',
      ),
    ],
  ],
);
