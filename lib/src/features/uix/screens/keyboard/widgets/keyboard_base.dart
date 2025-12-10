import 'package:flutter/material.dart';
import 'package:parkingson_key/src/models/keyboard_layout_model.dart';

typedef OnKeyPressed = void Function(String value);

class KeyboardBase extends StatelessWidget {
  final KeyboardLayoutModel layout;
  final double spacing;
  final OnKeyPressed onKeyPressed;

  const KeyboardBase({
    super.key,
    required this.layout,
    required this.onKeyPressed,
    this.spacing = 5,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, screenConstraints) {
        const double containerPadding = 8.0;

        final double availableWidth =
            (screenConstraints.maxWidth - containerPadding * 2).clamp(
              0.0,
              double.infinity,
            );
        final double availableHeight =
            (screenConstraints.maxHeight - containerPadding * 2).clamp(
              0.0,
              double.infinity,
            );

        final rowsData =
            MediaQuery.of(context).orientation == Orientation.portrait
            ? layout.portrait
            : layout.landscape;

        double globalMinFontSize = double.infinity;

        final int rowsCount = rowsData.length;
        final double totalVerticalSpacing = spacing * (rowsCount - 1);
        final double rowHeight =
            ((availableHeight - totalVerticalSpacing) / rowsCount).clamp(
              1.0,
              double.infinity,
            );

        for (var row in rowsData) {
          final int totalUnits = row.fold<int>(0, (p, e) => p + e.units);
          final double totalHorizontalSpacing = spacing * (row.length - 1);
          final double unitsAvailableWidth =
              (availableWidth - totalHorizontalSpacing).clamp(
                1.0,
                double.infinity,
              );
          final double unitWidth = unitsAvailableWidth / totalUnits;

          for (var key in row) {
            final double buttonWidth = (unitWidth * key.units).clamp(
              1.0,
              double.infinity,
            );

            const double innerHorizontalMargin = 1.0;
            const double innerVerticalMargin = 1.0;

            final double usableWidth = (buttonWidth - innerHorizontalMargin * 2)
                .clamp(1.0, double.infinity);
            final double usableHeight = (rowHeight - innerVerticalMargin * 2)
                .clamp(1.0, double.infinity);

            final double fontH = usableHeight * 0.6;

            final int len = (key.label == 'Space') ? 3 : key.label.length;
            final double charSpace = usableWidth / len;
            final double fontW = charSpace * 0.85;

            final double fontForButton = fontH < fontW ? fontH : fontW;

            if (fontForButton < globalMinFontSize) {
              globalMinFontSize = fontForButton;
            }
          }
        }

        if (globalMinFontSize.isInfinite || globalMinFontSize.isNaN) {
          globalMinFontSize = rowHeight * 0.45;
        }

        final double minSize = 8.0;
        final double maxSize = rowHeight * 0.9;
        globalMinFontSize = globalMinFontSize.clamp(minSize, maxSize);

        return Container(
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
                              right: i < rowsData[r].length - 1 ? spacing : 0,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                final label = rowsData[r][i].label == 'Space'
                                    ? ' '
                                    : rowsData[r][i].label;
                                onKeyPressed(label);
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black,
                                backgroundColor: switch (rowsData[r][i].label) {
                                  'ESPACIO' || 'SPACE' => Colors.green,
                                  'YES' || 'SÍ' || 'NO' => Colors.red,
                                  'A' ||
                                  'E' ||
                                  'I' ||
                                  'O' ||
                                  'U' => Colors.indigo.shade300,
                                  _ => Colors.blue,
                                },
                                padding: EdgeInsets.zero,
                                alignment: Alignment.center,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                rowsData[r][i].label.toUpperCase(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                textHeightBehavior: const TextHeightBehavior(
                                  applyHeightToFirstAscent: false,
                                  applyHeightToLastDescent: false,
                                ),
                                style: TextStyle(fontSize: globalMinFontSize+10, fontWeight: FontWeight.bold,),
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
    );
  }
}
