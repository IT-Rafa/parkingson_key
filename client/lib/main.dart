import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:parkingson_key/src/core/bootstrap/app_bootstrap.dart';
import 'package:parkingson_key/src/core/providers/app_language_enum.dart';
import 'package:parkingson_key/src/core/providers/contact_storage_provider.dart';
import 'package:parkingson_key/src/core/providers/language_provider.dart';
import 'package:parkingson_key/src/core/providers/phrase_tree_storage_provider.dart';
import 'package:parkingson_key/src/core/providers/shared_prefs_provider.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/keyboard_screen.dart';
import 'package:parkingson_key/src/features/uix/themes/my_themes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  final bootstrap = await AppBootstrap.init();
  runApp(
    ProviderScope(
      overrides: [
        contactStorageProvider.overrideWithValue(
          bootstrap.contactStorage,
        ),
        phraseTreeStorageProvider.overrideWithValue(
          bootstrap.phraseTreeStorage,
        ),
        sharedPrefsProvider.overrideWithValue(
          bootstrap.prefs,
        ),
        languageProvider.overrideWith(
          () => LanguageController(bootstrap.savedLang),
        ),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('es')],
        path: 'assets/langs',
        fallbackLocale: const Locale('en'),
        startLocale: bootstrap.savedLang == AppLanguage.es
            ? const Locale('es')
            : const Locale('en'),
        useOnlyLangCode: true,
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Parkingson Key',
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const KeyboardScreen(),
    );
  }
}
