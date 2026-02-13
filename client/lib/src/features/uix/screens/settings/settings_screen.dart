import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/app_language_enum.dart';
import 'package:parkingson_key/src/core/providers/keyboard_preset_provider.dart';
import 'package:parkingson_key/src/core/providers/keyboard_profile_provider.dart';
import 'package:parkingson_key/src/core/providers/language_provider.dart';
import 'package:parkingson_key/src/core/providers/theme_provider.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/utils/keyboard_accessibility_profiles.dart';
import 'package:parkingson_key/src/features/uix/screens/settings/widgets/contacts_settings_screen.dart';
import 'package:parkingson_key/src/features/uix/screens/settings/widgets/keyboard_design_section.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_accessibility_preset.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_accessibility_profile.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String theme = ref.watch(themeProvider);
    final profile = ref.watch(keyboardProfileProvider);
    final preset = ref.watch(keyboardPresetProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("SETTINGS_settings").tr()),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Idioma ---
                Row(
                  children: [
                    const Text("SETTINGS_language").tr(),
                    const SizedBox(width: 20),
                    DropdownButton<AppLanguage>(
                      value: ref.watch(languageProvider),
                      items: AppLanguage.values.map((lang) {
                        return DropdownMenuItem(
                          value: lang,
                          child: Text(
                              lang == AppLanguage.en ? 'English' : 'Español'),
                        );
                      }).toList(),
                      onChanged: (lang) async {
                        if (lang == null) return;

                        // Cambia EasyLocalization
                        await context.setLocale(lang == AppLanguage.en
                            ? const Locale('en')
                            : const Locale('es'));

                        // Cambia Riverpod + SharedPreferences
                        await ref
                            .read(languageProvider.notifier)
                            .setLanguage(lang);
                      },
                    )
                  ],
                ),

                const SizedBox(height: 15),

                // --- Tema ---
                Row(
                  children: [
                    const Text("SETTINGS_theme").tr(),
                    const SizedBox(width: 20),
                    DropdownButton<String>(
                      value: theme,
                      items: [
                        DropdownMenuItem(
                          value: "light",
                          child: Text("SETTINGS_light_mode").tr(),
                        ),
                        DropdownMenuItem(
                          value: "dark",
                          child: Text("SETTINGS_dark_mode").tr(),
                        ),
                        DropdownMenuItem(
                          value: "system",
                          child: Text("SETTINGS_system_mode").tr(),
                        ),
                      ],
                      onChanged: (value) {
                        ref.read(themeProvider.notifier).setTheme(value!);
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // --- Slider delay ---
                Text("SETTINGS_key_delay").tr(),
                Slider(
                  min: 100,
                  max: 800,
                  divisions: 14,
                  value: profile.acceptHoldDuration.inMilliseconds.toDouble(),
                  label: "${profile.acceptHoldDuration.inMilliseconds} ms",
                  onChanged: (v) {
                    ref
                        .read(keyboardProfileProvider.notifier)
                        .setAcceptHold(Duration(milliseconds: v.round()));
                  },
                ),

                const SizedBox(height: 20),

                // --- Vibración ---
                Row(
                  children: [
                    const Text("SETTINGS_haptic").tr(),
                    Switch(
                      value: profile.hapticEnabled,
                      onChanged: (value) {
                        ref
                            .read(keyboardProfileProvider.notifier)
                            .setHapticEnabled(value);
                      },
                    ),
                  ],
                ),

                Row(
                  children: [
                    const Text("SETTINGS_vibration_level").tr(),
                    const SizedBox(width: 20),
                    DropdownButton<HapticLevel>(
                      value: profile.hapticLevel,
                      items: [
                        DropdownMenuItem(
                          value: HapticLevel.soft,
                          child: Text("SETTINGS_light").tr(),
                        ),
                        DropdownMenuItem(
                          value: HapticLevel.strong,
                          child: Text("SETTINGS_strong").tr(),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          ref
                              .read(keyboardProfileProvider.notifier)
                              .setHapticLevel(value);
                        }
                      },
                    ),
                  ],
                ),

                // --- Perfil de accesibilidad ---
                Row(
                  children: [
                    const Text("SETTINGS_accessibility_profile").tr(),
                    const SizedBox(width: 20),
                    DropdownButton<KeyboardAccessibilityPreset>(
                      value: preset,
                      items: [
                        DropdownMenuItem(
                          value: KeyboardAccessibilityPreset.light,
                          child: Text("SETTINGS_light").tr(),
                        ),
                        DropdownMenuItem(
                          value: KeyboardAccessibilityPreset.medium,
                          child: Text("SETTINGS_medium").tr(),
                        ),
                        DropdownMenuItem(
                          value: KeyboardAccessibilityPreset.strong,
                          child: Text("SETTINGS_strong").tr(),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          ref
                              .read(keyboardPresetProvider.notifier)
                              .setPreset(value);

                          final profile =
                              KeyboardAccessibilityProfiles.presets[value]!;
                          ref
                              .read(keyboardProfileProvider.notifier)
                              .setProfile(profile);
                        }
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // --- Sección de contactos ---
                const Text("SETTINGS_contacts",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )).tr(),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  icon: const Icon(Icons.contacts),
                  label: const Text("SETTINGS_manage_contacts").tr(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ContactsSettingsScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                // --- keyboard type ---
                const KeyboardDesignSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
