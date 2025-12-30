import 'package:flutter/material.dart';

class KeyboardDropdownKey extends StatelessWidget {
  const KeyboardDropdownKey({
    super.key,
    required this.title,
    required this.items,
    required this.onChanged,
    this.color, Color? darkColor, Color? lightColor,
  });

  final String title;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.fromLTRB(4, 4, 4, 0),
      decoration: BoxDecoration(
        color: color ?? Colors.green[400],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          isDense: true,
          icon: const Icon(Icons.arrow_drop_down, size: 30),

          // 👇 SIEMPRE visible
          hint: _titleWidget(),

          // 👇 SIEMPRE visible incluso tras seleccionar
          selectedItemBuilder: (context) {
            return items.map((_) => _titleWidget()).toList();
          },

          items: items
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Center(child: Text(item)),
                ),
              )
              .toList(),

          // 👇 AQUÍ está la acción real
          onChanged: (value) {
            if (value == null) return;
            onChanged?.call(value);
          },
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return Center(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
