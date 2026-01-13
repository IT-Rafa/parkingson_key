import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/app_language_enum.dart';
import 'package:parkingson_key/src/core/providers/keyboard_preset_provider.dart';
import 'package:parkingson_key/src/core/providers/keyboard_profile_provider.dart';
import 'package:parkingson_key/src/core/providers/language_provider.dart';
import 'package:parkingson_key/src/core/providers/theme_provider.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/utils/keyboard_accessibility_profiles.dart';
import 'package:parkingson_key/src/features/uix/screens/settings/utils/locale_from_language_code.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_accessibility_preset.dart';
import 'package:parkingson_key/src/models/keyboard/keyboard_accessibility_profile.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLanguage lang = ref.watch(languageProvider);
    final String theme = ref.watch(themeProvider);
    final profile = ref.watch(keyboardProfileProvider);
    final preset = ref.watch(keyboardPresetProvider);

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
                  DropdownButton<AppLanguage>(
                    value: lang,
                    items: [
                      DropdownMenuItem(
                        value: AppLanguage.en,
                        child: Text("SETTINGS_english").tr(),
                      ),
                      DropdownMenuItem(
                        value: AppLanguage.es,
                        child: Text("SETTINGS_spanish").tr(),
                      ),
                    ],
                    onChanged: (value) {
                      // Actualizar Riverpod (persistencia)
                      ref.read(languageProvider.notifier).setLanguage(value!);
                      // Actualizar EasyLocalization
                      // EasyLocalization tiene su propio estado interno
                      context.setLocale(
                        localeFromLanguageCode(value),
                      ); // map AppLanguage -> Locale
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

              const SizedBox(height: 20),
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
              Row(
                children: [
                  const Text("Vibración activada"),
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
                  const Text("Vibración"),
                  const SizedBox(width: 20),
                  DropdownButton<HapticLevel>(
                    value: profile.hapticLevel,
                    items: const [
                      DropdownMenuItem(
                        value: HapticLevel.soft,
                        child: Text("Suave"),
                      ),
                      DropdownMenuItem(
                        value: HapticLevel.strong,
                        child: Text("Fuerte"),
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

              Row(
                children: [
                  const Text("Perfil de accesibilidad"),
                  const SizedBox(width: 20),
                  DropdownButton<KeyboardAccessibilityPreset>(
                    value: preset,
                    items: const [
                      DropdownMenuItem(
                        value: KeyboardAccessibilityPreset.light,
                        child: Text("Leve"),
                      ),
                      DropdownMenuItem(
                        value: KeyboardAccessibilityPreset.medium,
                        child: Text("Medio"),
                      ),
                      DropdownMenuItem(
                        value: KeyboardAccessibilityPreset.strong,
                        child: Text("Fuerte"),
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
            ],
          ),
        ),
      ),
    );
  }
}
