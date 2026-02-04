import 'package:flutter/material.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_item.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_layout.dart';

final esAbcdeKeyboardLayout = KeyboardLayout(
  id: 'es_abcde',
  // ───────────────── PORTRAIT ─────────────────
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
      KeyboardItem.char('ll'),
      KeyboardItem.char('m'),
      KeyboardItem.char('n'),
    ],
    [
      KeyboardItem.char('ñ'),
      KeyboardItem.char('o'),
      KeyboardItem.char('p'),
      KeyboardItem.char('q'),
      KeyboardItem.char('qu'),
    ],
    [
      KeyboardItem.char('r'),
      KeyboardItem.char('rr'),
      KeyboardItem.char('s'),
      KeyboardItem.char('t'),
      KeyboardItem.char('u'),
    ],
    [
      KeyboardItem.char('v'),
      KeyboardItem.char('w'),
      KeyboardItem.char('x'),
      KeyboardItem.char('y'),
      KeyboardItem.char('z'),
    ],
    [
      KeyboardItem.char('Sí', lightColor: Colors.green),
      KeyboardItem.char('No', lightColor: Colors.green),
      KeyboardItem.char('a'),
      KeyboardItem.char('e'),
      KeyboardItem.char('i'),
      KeyboardItem.char('o'),
      KeyboardItem.char('u'),
      KeyboardItem.char(' '),
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
      KeyboardItem.char('ll'),
      KeyboardItem.char('m'),
      KeyboardItem.char('n'),
    ],
    [
      KeyboardItem.char('ñ'),
      KeyboardItem.char('o'),
      KeyboardItem.char('p'),
      KeyboardItem.char('q'),
      KeyboardItem.char('qu'),
      KeyboardItem.char('r'),
      KeyboardItem.char('rr'),
    ],
    [
      KeyboardItem.char('s'),
      KeyboardItem.char('t'),
      KeyboardItem.char('u'),
      KeyboardItem.char('v'),
      KeyboardItem.char('w'),
      KeyboardItem.char('x'),
      KeyboardItem.char('y'),
      KeyboardItem.char('z'),
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
);
