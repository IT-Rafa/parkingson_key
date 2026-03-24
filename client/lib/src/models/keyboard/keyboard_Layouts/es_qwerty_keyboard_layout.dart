import 'package:parkingson_key/src/models/keyboard/keyboard_item.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_layout.dart';

final esQwertyKeyboardLayout = KeyboardLayout(
  id: 'es_qwerty',
  // ───────────────── PORTRAIT ─────────────────
  portrait: [
    [
      KeyboardItem.char('q'),
      KeyboardItem.char('w'),
      KeyboardItem.char('e'),
      KeyboardItem.char('r'),
      KeyboardItem.char('t'),
      KeyboardItem.char('y'),
      KeyboardItem.char('u'),
      KeyboardItem.char('i'),
      KeyboardItem.char('o'),
      KeyboardItem.char('p'),
    ],
    [
      KeyboardItem.char('a'),
      KeyboardItem.char('s'),
      KeyboardItem.char('d'),
      KeyboardItem.char('f'),
      KeyboardItem.char('g'),
      KeyboardItem.char('h'),
      KeyboardItem.char('j'),
      KeyboardItem.char('k'),
      KeyboardItem.char('l'),
      KeyboardItem.char('ñ'),
    ],
    [
      KeyboardItem.char('z'),
      KeyboardItem.char('x'),
      KeyboardItem.char('c'),
      KeyboardItem.char('v'),
      KeyboardItem.char('b'),
      KeyboardItem.char('n'),
      KeyboardItem.char('m'),
      KeyboardItem.char('Sí'),
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
      KeyboardItem.action(
        title: 'KEYBOARD_phrases',
      ),
    ],
  ],
  // ───────────────── LANDSCAPE ─────────────────
  landscape: [
    [
      KeyboardItem.char('q'),
      KeyboardItem.char('w'),
      KeyboardItem.char('e'),
      KeyboardItem.char('r'),
      KeyboardItem.char('t'),
      KeyboardItem.char('y'),
      KeyboardItem.char('u'),
      KeyboardItem.char('i'),
      KeyboardItem.char('o'),
      KeyboardItem.char('p'),
    ],
    [
      KeyboardItem.char('a'),
      KeyboardItem.char('s'),
      KeyboardItem.char('d'),
      KeyboardItem.char('f'),
      KeyboardItem.char('g'),
      KeyboardItem.char('h'),
      KeyboardItem.char('j'),
      KeyboardItem.char('k'),
      KeyboardItem.char('l'),
      KeyboardItem.char('ñ'),
    ],
    [
      KeyboardItem.char('z'),
      KeyboardItem.char('x'),
      KeyboardItem.char('c'),
      KeyboardItem.char('v'),
      KeyboardItem.char('b'),
      KeyboardItem.char('n'),
      KeyboardItem.char('m'),
      KeyboardItem.char('Sí'),
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
      KeyboardItem.action(
        title: 'KEYBOARD_phrases',
      ),
    ],
  ],
);
