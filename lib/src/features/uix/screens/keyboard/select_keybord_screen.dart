import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// --- CLASE DEL BOTÓN ---
class KeyItem {
  final String label;
  final int units; // 1 normal, 2 doble ancho
  KeyItem(this.label, this.units);
}

// --- TECLADO FINAL ---
class SelectKeyboardScreen extends ConsumerWidget {
  const SelectKeyboardScreen({super.key});

  static const double spacing = 6;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<List<KeyItem>> rowsData = [
      [
        KeyItem('q', 1),
        KeyItem('w', 1),
        KeyItem('e', 1),
        KeyItem('r', 1),
        KeyItem('t', 1),
        KeyItem('y', 1),
        KeyItem('u', 1),
        KeyItem('i', 1),
        KeyItem('o', 1),
        KeyItem('p', 1),
      ],
      [
        KeyItem('a', 1),
        KeyItem('s', 1),
        KeyItem('d', 1),
        KeyItem('f', 1),
        KeyItem('g', 1),
        KeyItem('h', 1),
        KeyItem('j', 1),
        KeyItem('k', 1),
        KeyItem('l', 1),
      ],
      [
        KeyItem('z', 1),
        KeyItem('x', 1),
        KeyItem('c', 1),
        KeyItem('v', 1),
        KeyItem('b', 1),
        KeyItem('n', 1),
        KeyItem('m', 1),
      ],
      [KeyItem('space', 2), KeyItem('del', 1)],
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            for (int r = 0; r < rowsData.length; r++)
              Expanded(
                child: Row(
                  children: [
                    for (int i = 0; i < rowsData[r].length; i++)
                      Expanded(
                        flex: rowsData[r][i].units,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: i < rowsData[r].length - 1 ? spacing : 0,
                          ),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final fontSize =
                                  constraints.maxHeight *
                                  0.5; // 50% de la altura
                              return ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  alignment: Alignment.center,
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.primary,
                                ),
                                child: Center(
                                  child: Text(
                                    rowsData[r][i].label,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: fontSize,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
