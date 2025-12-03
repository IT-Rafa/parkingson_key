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

    return Scaffold(
      appBar: AppBar(title: const Text("SETTINGS_settings").tr()),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("SETTINGS_language").tr(),
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
            const SizedBox(height: 32),
            const Text("SETTINGS_theme").tr(),

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

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Teclado preferido",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  DropdownButtonFormField<String>(
                    initialValue: selectedId ?? keyboards.first.id,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Selecciona teclado",
                    ),
                    items: keyboards.map((k) {
                      return DropdownMenuItem(value: k.id, child: Text(k.name));
                    }).toList(),
                    onChanged: (newId) {
                      if (newId != null) {
                        ref
                            .read(selectedKeyboardIdProvider.notifier)
                            .setKeyboard(newId);
                      }
                    },
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "La app elegirá automáticamente la versión portrait/landscape según la orientación.",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
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
