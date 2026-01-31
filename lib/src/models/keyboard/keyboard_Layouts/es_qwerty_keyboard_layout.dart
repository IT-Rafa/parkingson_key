import 'package:flutter/material.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_item.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_layout.dart';

final esQwertyKeyboardLayout = KeyboardLayout(
  id: 'es_qwerty',
  // ───────────────── PORTRAIT ─────────────────
  portrait: [
    [
      KeyboardItem.char('q'),
      KeyboardItem.char('w'),
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
    ],
    [
      KeyboardItem.char('Sí', lightColor: Colors.green),
      KeyboardItem.char('No', lightColor: Colors.green),
      KeyboardItem.char('  '),
    ],
    [
      KeyboardItem.dropdown(
        title: 'Symbols',
        items: ['!', '@', '#', '\$', '%', '^', '&', '*'],
      ),
      KeyboardItem.dropdown(
        title: 'Numbers',
        items: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'],
      ),
    ],
  ],
  // ───────────────── LANDSCAPE ─────────────────
  landscape: [
    [
      KeyboardItem.char('q'),
      KeyboardItem.char('w'),
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
      KeyboardItem.char('Sí', lightColor: Colors.green),
      KeyboardItem.char('No', lightColor: Colors.green),
    ],
    [
      KeyboardItem.dropdown(
        title: 'Symbols',
        items: ['!', '@', '#', '\$', '%', '^', '&', '*'],
      ),
      KeyboardItem.dropdown(
        title: 'Numbers',
        items: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'],
      ),
    ],
  ],
);
