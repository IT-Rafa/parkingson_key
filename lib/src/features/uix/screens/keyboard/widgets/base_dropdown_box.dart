import 'package:flutter/material.dart';

class BaseDropdownBox extends StatelessWidget {
  final String title;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String> onSelected;
  final Orientation orientation;

  const BaseDropdownBox({
    super.key,
    required this.title,
    required this.items,
    required this.onSelected,
    required this.orientation,
  });

  @override
  Widget build(BuildContext context) {
    // Padding vertical según orientación
    final double verticalPadding = orientation == Orientation.portrait ? 4 : 2;

    return Container(
      padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14),
          ),
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, size: 20),
          value: null, // ❌ Siempre null para mostrar solo título
          items: items,
          onChanged: (value) {
            if (value != null) onSelected(value);
          },
        ),
      ),
    );
  }
}
