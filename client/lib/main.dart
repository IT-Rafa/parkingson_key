import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parkingson_key/src/core/persistence/phrases/phrase_tree_storage.dart';
import 'package:parkingson_key/src/core/providers/app_language_enum.dart';
import 'package:parkingson_key/src/core/providers/language_provider.dart';
import 'package:parkingson_key/src/core/providers/shared_prefs_provider.dart';
import 'package:parkingson_key/src/core/persistence/contacts/contact_storage.dart';
import 'package:parkingson_key/src/core/persistence/contacts/default_contacts_factory.dart';
import 'package:parkingson_key/src/core/contacts/providers/contact_storage_provider.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/keyboard_screen.dart';
import 'package:parkingson_key/src/models/phrase/phrase_node.dart';
import 'package:parkingson_key/src/core/phrases/providers/phrase_tree_storage_provider.dart';
import 'package:parkingson_key/src/features/uix/themes/my_themes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/models/contacts/contact.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Inicializa Hive
  await Hive.initFlutter();
  Hive.registerAdapter(ContactAdapter());
  Hive.registerAdapter(PhraseNodeAdapter());

  // Instancia y inicializa PhraseTreeStorage
  final phraseStorage = PhraseTreeStorage();
  await phraseStorage.init();

  // Inicializa ContactStorage
  final contactStorage = ContactStorage();
  await contactStorage.init();
  if (contactStorage.isEmpty) {
    await contactStorage.save(DefaultContactsFactory.create());
  }

  // SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  // Carga idioma guardado
  final savedLang = await LanguageController.loadSavedLanguage();

  runApp(
    ProviderScope(
      overrides: [
        sharedPrefsProvider.overrideWithValue(prefs),
        phraseTreeStorageProvider.overrideWithValue(phraseStorage),
        contactStorageProvider.overrideWithValue(contactStorage),
        languageProvider.overrideWith(
          () => LanguageController(savedLang),
        ),
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