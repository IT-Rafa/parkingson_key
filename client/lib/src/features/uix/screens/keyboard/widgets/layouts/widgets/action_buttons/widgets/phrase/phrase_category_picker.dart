import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Asumo que usas el mismo notifier para navegar que en el otro widget
import 'package:parkingson_key/src/core/phrase_tree_navigator.dart'; 


class PhraseCategoryPicker extends ConsumerWidget {
  const PhraseCategoryPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Obtenemos los nodos del nivel actual del navegador
    final nodes = ref.watch(phraseTreeNavigatorProvider);
    final navigator = ref.read(phraseTreeNavigatorProvider.notifier);

    // FILTRO: Solo queremos mostrar nodos que sean categorías
    final categoryNodes = nodes.where((node) => node.isCategory).toList();

    return SafeArea(
      // Usamos Column y MainAxisSize.min para que el BottomSheet se ajuste
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Cabecera con botón de retroceso (estilo similar al que pasaste)
          ListTile(
            leading: navigator.currentPath == "KEYBOARD_topics".tr()
                ? const Icon(Icons.folder_special) // Icono raíz
                : IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => navigator.goBack(),
                  ),
            title: Text(
              navigator.currentPath,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Selecciona una categoría destino"),
          ),
          const Divider(height: 1),
          
          // Lista de categorías
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: categoryNodes.length,
              itemBuilder: (context, index) {
                final node = categoryNodes[index];

                return ListTile(
                  leading: const Icon(Icons.folder_open, color: Colors.amber),
                  title: Text(node.title),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Botón para entrar si tiene subcategorías
                      if (node.children.any((child) => child.isCategory))
                        const Icon(Icons.chevron_right),
                      const SizedBox(width: 8),
                      // Botón de acción principal: Seleccionar esta carpeta
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, node.id),
                        child: Text("Seleccionar"),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Al tocar el cuerpo del ListTile, entramos en la categoría
                    navigator.enterNode(node);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
