import 'package:flutter/material.dart';

class SymbolsDropdown extends StatelessWidget {
  final void Function(String symbol) onSymbolSelected;

  const SymbolsDropdown({
    super.key,
    required this.onSymbolSelected,
  });

  static const symbols = [
    '.', ',', ';', ':', '!', '?', '…', '"', "'", '-', '_',
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      decoration: const InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
      hint: const Text("Selecciona símbolo"),
      items: symbols.map(
        (s) => DropdownMenuItem(
          value: s,
          child: Text(
            s,
            style: const TextStyle(fontSize: 22),
          ),
        ),
      ).toList(),
      onChanged: (value) {
        if (value != null) onSymbolSelected(value); // 👈 mágicamente insertado
      },
    );
  }
}
