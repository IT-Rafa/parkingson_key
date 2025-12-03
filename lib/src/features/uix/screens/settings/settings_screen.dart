import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/keyboards_provider.dart';
import 'package:parkingson_key/src/core/providers/language_provider.dart';
import 'package:parkingson_key/src/core/providers/selected_keyboard_id_provider.dart';
import 'package:parkingson_key/src/core/providers/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(languageProvider);
    final theme = ref.watch(themeProvider);
    final keyboards = ref.watch(keyboardsProvider);
    final selectedId = ref.watch(selectedKeyboardIdProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("SETTINGS_settings").tr()),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text("SETTINGS_language").tr(),
                  const SizedBox(width: 20),
                  DropdownButton<String>(
                    value: lang,
                    items: [
                      DropdownMenuItem(
                        value: "en",
                        child: Text("SETTINGS_english").tr(),
                      ),
                      DropdownMenuItem(
                        value: "es",
                        child: Text("SETTINGS_spanish").tr(),
                      ),
                    ],
                    onChanged: (value) {
                      // Actualizar Riverpod (persistencia)
                      ref.read(languageProvider.notifier).setLanguage(value!);
                      // Actualizar EasyLocalization
                      // EasyLocalization tiene su propio estado interno

                      context.setLocale(Locale(value));
                    },
                  ),
                ],
              ),

              const SizedBox(height: 15),
              Row(
                children: [
                  const Text("SETTINGS_theme").tr(),
                  const SizedBox(width: 20),
                  DropdownButton<String>(
                    value: theme,
                    items: [
                      DropdownMenuItem(
                        value: "light",
                        child: Text("SETTINGS_light").tr(),
                      ),
                      DropdownMenuItem(
                        value: "dark",
                        child: Text("SETTINGS_dark").tr(),
                      ),
                      DropdownMenuItem(
                        value: "system",
                        child: Text("SETTINGS_system").tr(),
                      ),
                    ],
                    onChanged: (value) {
                      ref.read(themeProvider.notifier).setTheme(value!);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 15),

              const Text("Selecciona teclado:"),

              Container(
                margin: const EdgeInsets.only(left: 8),
                child: 
                  DropdownButtonFormField<String>(
                    isExpanded: true, // 🔥 oculta overflow y usa todo el ancho
                    decoration: const InputDecoration(
                      border: InputBorder.none, // ❌ sin subrayado
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ), // 🔥 hace que el dropdown use todo el ancho disponible
                    initialValue: selectedId ?? keyboards.first.id,
                    items: keyboards
                        .map(
                          (k) => DropdownMenuItem(
                            value: k.id,
                            child: Flexible(
                              // 👈 permite varias líneas
                              child: Text(
                                k.name,
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {},
                  ),
                
              ),
            ],
          ),
        ),
      ),
    );
  }
}
