import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parkingson_key/src/core/phrases/phrase_tree/phrase_tree_storage.dart';
import 'package:parkingson_key/src/core/providers/app_language_enum.dart';
import 'package:parkingson_key/src/core/providers/language_provider.dart';
import 'package:parkingson_key/src/core/providers/shared_prefs_provider.dart';
import 'package:parkingson_key/src/core/providers/theme_provider.dart';
import 'package:parkingson_key/src/core/persistence/contacts/contact_storage.dart';
import 'package:parkingson_key/src/core/persistence/contacts/default_contacts_factory.dart';
import 'package:parkingson_key/src/core/contacts/providers/contact_storage_provider.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/keyboard_screen.dart';
import 'package:parkingson_key/src/core/phrases/model/default_phrase_factory.dart';
import 'package:parkingson_key/src/models/phrase/phrase_node.dart';
import 'package:parkingson_key/src/core/phrases/providers/phrase_tree_storage_provider.dart';
import 'package:parkingson_key/src/features/uix/screens/settings/settings_screen.dart';
import 'package:parkingson_key/src/features/uix/themes/my_themes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/models/contacts/contact.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Inicializa Hive
  await Hive.initFlutter();
  Hive.registerAdapter(PhraseNodeAdapter());
  Hive.registerAdapter(ContactAdapter());

  // Inicializa almacenamiento de frases
  final phraseStorage = PhraseTreeStorage();
  await phraseStorage.init();

  // Carga SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  // Carga idioma guardado
  final savedLang = await LanguageController.loadSavedLanguage();

  // Inicializa Hive de frases
  final box = await Hive.openBox<List>('phrase_tree_box');
  if (!box.containsKey('phrases')) {
    final defaultTree = DefaultPhraseFactory.create(savedLang);
    await box.put('phrases', defaultTree);
  }

  // Contactos
  final contactStorage = ContactStorage();
  await contactStorage.init();
  if (contactStorage.isEmpty) {
    await contactStorage.save(DefaultContactsFactory.create());
  }

  // Ahora sí, runApp con ProviderScope
  runApp(
    ProviderScope(
      overrides: [
        languageProvider.overrideWith(() => LanguageController(savedLang)),
        sharedPrefsProvider.overrideWithValue(prefs),
        phraseTreeStorageProvider.overrideWithValue(phraseStorage),
        contactStorageProvider.overrideWithValue(contactStorage),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('es')],
        path: 'assets/langs',
        fallbackLocale: const Locale('en'),
        startLocale: savedLang == AppLanguage.es
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
    final themeCode = ref.watch(themeProvider);
    final themeMode = _parseTheme(themeCode);

    return MaterialApp(
      title: "KEYBOARD_title".tr(),
      debugShowCheckedModeBanner: false,
      // Locale dinámico
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      // Tema dinámico
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      themeMode: themeMode,
      // RUTA PRINCIPAL
      home: const KeyboardScreen(),
      // Navegación dinámica
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/settings':
            return MaterialPageRoute(builder: (_) => const SettingsScreen());
        }
        return null;
      },
    );
  }
}

ThemeMode _parseTheme(String mode) {
  switch (mode) {
    case "light":
      return ThemeMode.light;
    case "dark":
      return ThemeMode.dark;
    default:
      return ThemeMode.system;
  }
}
