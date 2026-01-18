import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parkingson_key/src/core/persistence/phrase_tree_storage.dart';
import 'package:parkingson_key/src/core/providers/app_language_enum.dart';
import 'package:parkingson_key/src/core/providers/language_provider.dart';
import 'package:parkingson_key/src/core/providers/shared_prefs_provider.dart';
import 'package:parkingson_key/src/core/providers/theme_provider.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/keyboard_screen.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/phrases/model/default_phrase_factory.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/phrases/model/phrase_node.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/phrases/providers/phrase_tree_storage_provider.dart';
import 'package:parkingson_key/src/features/uix/screens/settings/settings_screen.dart';
import 'package:parkingson_key/src/features/uix/themes/my_themes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Inicializa Hive
  await Hive.initFlutter();

  Hive.registerAdapter(PhraseNodeAdapter());

  final phraseStorage = PhraseTreeStorage();
  await phraseStorage.init(); // 👈 ESTO ES CLAVE

  // Idioma actual del sistema o del usuario
  final AppLanguage lang = AppLanguage.es; // luego lo lees de tu provider real

  final box = await Hive.openBox<List>('phrase_tree_box');

  // Primer arranque
  if (!box.containsKey('phrases')) {
    final defaultTree = DefaultPhraseFactory.create(lang);
    await box.put('phrases', defaultTree);
  }
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPrefsProvider.overrideWithValue(prefs),
        phraseTreeStorageProvider.overrideWithValue(phraseStorage),
      ],
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('es')],
        path: 'assets/langs',
        fallbackLocale: const Locale('en'),
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
    final appLanguage = ref.watch(languageProvider);
    final themeCode = ref.watch(themeProvider);

    final themeMode = _parseTheme(themeCode);

    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,

      // locale dinámico
      locale: appLanguage.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,

      // tema dinámico
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      themeMode: themeMode,

      // RUTA PRINCIPAL,
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
