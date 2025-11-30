import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/key_item.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/del_texfield_icons/del_all_inkwell.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/del_texfield_icons/del_letter_inkwell.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/del_texfield_icons/del_word_inkwell.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/del_texfield_icons/read_inkwell.dart';

class KeyboardLandScreen extends ConsumerStatefulWidget {
  const KeyboardLandScreen({super.key});

  @override
  ConsumerState<KeyboardLandScreen> createState() => _KeyboardLandScreenState();
}

class _KeyboardLandScreenState extends ConsumerState<KeyboardLandScreen> {
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
      [KeyItem('B',1),KeyItem('C',1),KeyItem('D',1),KeyItem('F',1),KeyItem('G',1),KeyItem('H',1),KeyItem('J',1),KeyItem('K',1)],
      [KeyItem('L',1),KeyItem('LL',2),KeyItem('M',1),KeyItem('N',1),KeyItem('Ñ',1),KeyItem('P',1),KeyItem('Q',1),KeyItem('QU',2)],
      [KeyItem('R',1),KeyItem('RR',2),KeyItem('S',1),KeyItem('T',1),KeyItem('V',1),KeyItem('W',1),KeyItem('X',1),KeyItem('Y',1),KeyItem('Z',1)],
      [KeyItem('A',1),KeyItem('E',1),KeyItem('I',1),KeyItem('O',1),KeyItem('U',1),KeyItem('Space',2)],
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
                          contentPadding: EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                          border: OutlineInputBorder(),
                        ),
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
                      child: Center(child: ReadInkwell(controller: _controller)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    height: 48,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () => Navigator.pushNamed(context, '/settings'),
                    icon: const Icon(Icons.menu, size: 40),
                  ),
                ],
              ),

              // Teclado
              Expanded(
                child: Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    spacing: spacing,
                    children: [
                      for (int r=0;r<rowsData.length;r++)
                        Expanded(
                          child: LayoutBuilder(
                            builder: (context,rowConstraints) {
                              // --- Calcular fontSize mínimo para la fila ---
                              double minFontSize = double.infinity;
                              for(var key in rowsData[r]){
                                String label = key.label=='Space'?'Esp':key.label;
                                double fontSizeHeight = rowConstraints.maxHeight * 0.55;
                                double fontSizeWidth = (rowConstraints.maxWidth / rowsData[r].fold<int>(0,(p,e)=>p+e.units)) * key.units * 0.5;
                                double fontSizeButton = fontSizeHeight < fontSizeWidth ? fontSizeHeight : fontSizeWidth;
                                if(fontSizeButton<minFontSize) minFontSize = fontSizeButton;
                              }

                              return Row(
                                children: [
                                  for(int i=0;i<rowsData[r].length;i++)
                                    Expanded(
                                      flex: rowsData[r][i].units,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: i<rowsData[r].length-1?spacing:0),
                                        child: ElevatedButton(
                                          onPressed: ()=>_insertText(rowsData[r][i].label=='Space'?' ':rowsData[r][i].label),
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            alignment: Alignment.center,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                          ),
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              rowsData[r][i].label=='Space'?'Esp':rowsData[r][i].label,
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: minFontSize),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}