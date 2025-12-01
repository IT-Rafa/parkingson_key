import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/key_item.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/del_texfield_icons/del_all_inkwell.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/del_texfield_icons/del_letter_inkwell.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/del_texfield_icons/del_word_inkwell.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/del_texfield_icons/read_inkwell.dart';

class KeyboardPortScreen extends ConsumerStatefulWidget {
  const KeyboardPortScreen({super.key});

  @override
  ConsumerState<KeyboardPortScreen> createState() => _KeyboardPortScreenState();
}

class _KeyboardPortScreenState extends ConsumerState<KeyboardPortScreen> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  static const double spacing = 6;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _insertText(String value) {
    final newText = _controller.text + value;
    _controller.text = newText;
    _controller.selection = TextSelection.collapsed(offset: newText.length);
    if (!_focusNode.hasFocus) _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final rowsData = [
      [
        KeyItem('B', 1),
        KeyItem('C', 1),
        KeyItem('D', 1),
        KeyItem('F', 1),
        KeyItem('G', 1),
        KeyItem('H', 1),
      ],
      [KeyItem('J', 1), KeyItem('K', 1), KeyItem('L', 1), KeyItem('LL', 2)],
      [
        KeyItem('M', 1),
        KeyItem('N', 1),
        KeyItem('Ñ', 1),
        KeyItem('P', 1),
        KeyItem('Q', 1),
        KeyItem('QU', 2),
      ],
      [KeyItem('R', 1), KeyItem('RR', 2), KeyItem('S', 1), KeyItem('T', 1)],
      [
        KeyItem('V', 1),
        KeyItem('W', 1),
        KeyItem('X', 1),
        KeyItem('Y', 1),
        KeyItem('Z', 1),
      ],
      [
        KeyItem('A', 1),
        KeyItem('E', 1),
        KeyItem('I', 1),
        KeyItem('O', 1),
        KeyItem('U', 1),
        KeyItem('Space', 2),
      ],
    ];

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            spacing: 10,
            children: [
              // TextField + botones de borrar + menú
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        readOnly: true,
                        showCursor: true,
                        enableInteractiveSelection: false,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () => Navigator.pushNamed(context, '/settings'),
                    icon: const Icon(Icons.menu, size: 40),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    height: 48,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: ReadInkwell(controller: _controller),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 48,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),

                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 20,
                        children: [
                          DelLetterInkWell(controller: _controller),
                          DelWordInkWell(controller: _controller),
                          DelAllInkWell(controller: _controller),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              // Teclado
              // -------------------------------------------------------
              // TECLADO con fontSize unificado y cálculos robustos
              // -------------------------------------------------------
              Expanded(
                child: LayoutBuilder(
                  builder: (context, screenConstraints) {
                    // Padding interno del contenedor (coincide con el child Container padding)
                    const double containerPadding = 15.0;

                    // Espacio util disponible dentro del contenedor (restamos padding lateral)
                    final double availableWidth =
                        (screenConstraints.maxWidth - containerPadding * 2)
                            .clamp(0.0, double.infinity);
                    final double availableHeight =
                        (screenConstraints.maxHeight - containerPadding * 2)
                            .clamp(0.0, double.infinity);

                    double globalMinFontSize = double.infinity;

                    // Número de filas
                    final int rowsCount = rowsData.length;

                    // Altura disponible por fila (restamos spacing vertical entre filas)
                    final double totalVerticalSpacing =
                        spacing * (rowsCount - 1);
                    final double rowHeight =
                        ((availableHeight - totalVerticalSpacing) / rowsCount)
                            .clamp(1.0, double.infinity);

                    // Recorremos todas las filas y teclas para calcular el font mínimo global
                    for (var row in rowsData) {
                      // total de unidades de esa fila (suma de key.units)
                      final int totalUnits = row.fold<int>(
                        0,
                        (p, e) => p + e.units,
                      );

                      // restamos el spacing horizontal entre teclas de la fila
                      final double totalHorizontalSpacing =
                          spacing * (row.length - 1);

                      // ancho util para las unidades de esta fila
                      final double unitsAvailableWidth =
                          (availableWidth - totalHorizontalSpacing).clamp(
                            1.0,
                            double.infinity,
                          );

                      final double unitWidth = unitsAvailableWidth / totalUnits;

                      for (var key in row) {
                        // ancho y alto de la tecla (su espacio util)
                        final double buttonWidth = (unitWidth * key.units)
                            .clamp(1.0, double.infinity);

                        // Dejamos un pequeño margen interior para que el texto no quede pegado
                        final double innerHorizontalMargin = 6.0;
                        final double innerVerticalMargin = 4.0;

                        final double usableWidth =
                            (buttonWidth - innerHorizontalMargin * 2).clamp(
                              1.0,
                              double.infinity,
                            );
                        final double usableHeight =
                            (rowHeight - innerVerticalMargin * 2).clamp(
                              1.0,
                              double.infinity,
                            );

                        // font por altura (proporcional)
                        final double fontH = usableHeight * 0.6;

                        // font por anchura (aprox): dejamos que ocupe hasta un % del ancho por carácter
                        // para letras cortas esto funciona bien; usamos label length mínima 1
                        final int len = (key.label == 'Space')
                            ? 3
                            : key.label.length;
                        final double charSpace = usableWidth / len;
                        final double fontW =
                            charSpace * 0.85; // factor empirico para que quepa

                        final double fontForButton = fontH < fontW
                            ? fontH
                            : fontW;

                        if (fontForButton < globalMinFontSize) {
                          globalMinFontSize = fontForButton;
                        }
                      }
                    }

                    // Si por alguna razón no se actualizó (defensa), aplicamos un valor por defecto
                    if (globalMinFontSize.isInfinite ||
                        globalMinFontSize.isNaN) {
                      globalMinFontSize = rowHeight * 0.45;
                    }

                    // Clamp final para evitar tamaños aberrantes
                    final double minSize = 8.0;
                    final double maxSize = rowHeight * 0.9;
                    globalMinFontSize = globalMinFontSize.clamp(
                      minSize,
                      maxSize,
                    );

                    // Ahora renderizamos el teclado usando globalMinFontSize
                    return Container(
                      color: Colors.blue,
                      padding: const EdgeInsets.all(containerPadding),
                      child: Column(
                        spacing: spacing,
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
                                          right: i < rowsData[r].length - 1
                                              ? spacing
                                              : 0,
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () => _insertText(
                                            rowsData[r][i].label == 'Space'
                                                ? ' '
                                                : rowsData[r][i].label,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            alignment: Alignment.center,
                                            foregroundColor: Colors.red,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: Text(
                                            rowsData[r][i].label == 'Space'
                                                ? 'Esp'
                                                : rowsData[r][i].label,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: globalMinFontSize,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
