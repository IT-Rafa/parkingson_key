import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/language_provider.dart';
import 'package:parkingson_key/src/core/providers/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(languageProvider);
    final theme = ref.watch(themeProvider);

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
          ],
        ),
      ),
    );
  }
}
