import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_item.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_layout.dart';

final keyboardLayout = KeyboardLayout(
  // ───────────────── PORTRAIT ─────────────────
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
      KeyboardItem.char('ll'),
      KeyboardItem.char('m'),
      KeyboardItem.char('n'),
    ],
    [
      KeyboardItem.char('ñ'),
      KeyboardItem.char('p'),
      KeyboardItem.char('q'),
      KeyboardItem.char('qu'),
      KeyboardItem.char('r'),
      KeyboardItem.char('rr'),
    ],
    [
      KeyboardItem.char('s'),
      KeyboardItem.char('t'),
      KeyboardItem.char('v'),
      KeyboardItem.char('w'),
      KeyboardItem.char('x'),
      KeyboardItem.char('y'),
      KeyboardItem.char('z'),
    ],
    [
      KeyboardItem.char('a', color: Colors.cyan),
      KeyboardItem.char('e', color: Colors.cyan),
      KeyboardItem.char('i', color: Colors.cyan),
      KeyboardItem.char('o', color: Colors.cyan),
      KeyboardItem.char('u', color: Colors.cyan),
    ],
    [
      KeyboardItem.char('Sí', color: Colors.red),
      KeyboardItem.char('No', color: Colors.red),
      KeyboardItem.char('  ', color: Colors.grey),
    ],
    [
      KeyboardItem.dropdown(
        title: "KEYBOARD_numbers".tr(),
        items: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'],
      ),
      KeyboardItem.dropdown(
        title: "KEYBOARD_symbols".tr(),
        items: [
          '.',
          ',',
          ':',
          ';',
          '?',
          '!',
          '-',
          '_',
          '@',
          '#',
          '%',
          '&',
          '/',
          '+',
          '*',
        ],
      ),
    ],
  ],

  // ───────────────── LANDSCAPE ─────────────────
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
      KeyboardItem.char('ll'),
      KeyboardItem.char('m'),
      KeyboardItem.char('n'),
      KeyboardItem.char('ñ'),
      KeyboardItem.char('p'),
      KeyboardItem.char('q'),
      KeyboardItem.char('qu'),
    ],
    [
      KeyboardItem.char('r'),
      KeyboardItem.char('rr'),
      KeyboardItem.char('s'),
      KeyboardItem.char('t'),
      KeyboardItem.char('v'),
      KeyboardItem.char('w'),
      KeyboardItem.char('x'),
      KeyboardItem.char('y'),
      KeyboardItem.char('z'),
    ],
    [
      KeyboardItem.char('Sí', color: Colors.red),
      KeyboardItem.char('No', color: Colors.red),

      KeyboardItem.char('a', color: Colors.cyan),
      KeyboardItem.char('e', color: Colors.cyan),
      KeyboardItem.char('i', color: Colors.cyan),
      KeyboardItem.char('o', color: Colors.cyan),
      KeyboardItem.char('u', color: Colors.cyan),
      KeyboardItem.char('  ', color: Colors.grey),
    ],
    [
      KeyboardItem.dropdown(
        title: "KEYBOARD_numbers".tr(),
        items: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'],
      ),

      KeyboardItem.dropdown(
        title: "KEYBOARD_symbols".tr(),
        items: [
          '.',
          ',',
          ':',
          ';',
          '?',
          '!',
          '-',
          '_',
          '@',
          '#',
          '%',
          '&',
          '/',
          '+',
          '*',
        ],
      ),
    ],
  ],
);
