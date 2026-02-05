import 'package:flutter/material.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_item.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_layout.dart';

final esAbcdeKeyboardLayout = KeyboardLayout(
  id: 'es_abcde',
  // ───────────────── PORTRAIT ─────────────────
  portrait: [
    [
      KeyboardItem.char('a', lightColor: Colors.cyan),
      KeyboardItem.char('b'),
      KeyboardItem.char('c'),
      KeyboardItem.char('d'),
      KeyboardItem.char('e', lightColor: Colors.cyan),
    ],
    [
      KeyboardItem.char('f'),
      KeyboardItem.char('g'),
      KeyboardItem.char('h'),
      KeyboardItem.char('i', lightColor: Colors.cyan),
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
      KeyboardItem.char('o', lightColor: Colors.cyan),
      KeyboardItem.char('p'),
      KeyboardItem.char('q'),
      KeyboardItem.char('qu'),
    ],
    [
      KeyboardItem.char('r'),
      KeyboardItem.char('rr'),
      KeyboardItem.char('s'),
      KeyboardItem.char('t'),
      KeyboardItem.char('u', lightColor: Colors.cyan),
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
      KeyboardItem.char('  ', lightColor: Colors.grey),
    ],
    [
      KeyboardItem.dropdown(
        title: 'KEYBOARD_symbols',
        items: ['!', '@', '#', '\$', '%', '^', '&', '*'],
      ),
      KeyboardItem.dropdown(
        title: 'KEYBOARD_numbers',
        items: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'],
      ),
    ],
  ],
  // ───────────────── LANDSCAPE ─────────────────
  landscape: [
    [
      KeyboardItem.char('a', lightColor: Colors.cyan),
      KeyboardItem.char('b'),
      KeyboardItem.char('c'),
      KeyboardItem.char('d'),
      KeyboardItem.char('e', lightColor: Colors.cyan),
      KeyboardItem.char('f'),
      KeyboardItem.char('g'),
      KeyboardItem.char('h'),
    ],
    [
      KeyboardItem.char('i', lightColor: Colors.cyan),
      KeyboardItem.char('j'),
      KeyboardItem.char('k'),
      KeyboardItem.char('l'),
      KeyboardItem.char('ll'),
      KeyboardItem.char('m'),
      KeyboardItem.char('n'),
    ],
    [
      KeyboardItem.char('ñ'),
      KeyboardItem.char('o', lightColor: Colors.cyan),
      KeyboardItem.char('p'),
      KeyboardItem.char('q'),
      KeyboardItem.char('qu'),
      KeyboardItem.char('r'),
      KeyboardItem.char('rr'),
    ],
    [
      KeyboardItem.char('s'),
      KeyboardItem.char('t'),
      KeyboardItem.char('u', lightColor: Colors.cyan),
      KeyboardItem.char('v'),
      KeyboardItem.char('w'),
      KeyboardItem.char('x'),
      KeyboardItem.char('y'),
      KeyboardItem.char('z'),
    ],
    [
      KeyboardItem.char('Sí', lightColor: Colors.green),
      KeyboardItem.char('No', lightColor: Colors.green),
      KeyboardItem.char('  ', lightColor: Colors.grey),
    ],
    [
      KeyboardItem.dropdown(
        title: 'KEYBOARD_symbols',
        items: ['!', '@', '#', '\$', '%', '^', '&', '*'],
      ),
      KeyboardItem.dropdown(
        title: 'KEYBOARD_numbers',
        items: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'],
      ),
    ],
  ],
);
