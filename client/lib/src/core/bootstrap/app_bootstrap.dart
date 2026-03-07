import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parkingson_key/src/core/persistence/contacts/contact_storage.dart';
import 'package:parkingson_key/src/core/persistence/phrases/phrase_tree_storage.dart';
import 'package:parkingson_key/src/core/providers/app_language_enum.dart';
import 'package:parkingson_key/src/core/providers/language_provider.dart';
import 'package:parkingson_key/src/models/contacts/contact.dart';
import 'package:parkingson_key/src/models/phrase/phrase_node.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBootstrap {
  final ContactStorage contactStorage;
  final PhraseTreeStorage phraseTreeStorage;
  final SharedPreferences prefs;
  final AppLanguage savedLang;

  AppBootstrap({
    required this.contactStorage,
    required this.phraseTreeStorage,
    required this.prefs,
    required this.savedLang,
  });

  static Future<AppBootstrap> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();

    await Hive.initFlutter();

    Hive.registerAdapter(ContactAdapter());
    Hive.registerAdapter(PhraseNodeAdapter());

    final prefs = await SharedPreferences.getInstance();
    final savedLang = await LanguageController.loadSavedLanguage();

    final contactStorage = ContactStorage();
    await contactStorage.init();

    final phraseTreeStorage = PhraseTreeStorage();
    await phraseTreeStorage.init();

    return AppBootstrap(
      contactStorage: contactStorage,
      phraseTreeStorage: phraseTreeStorage,
      prefs: prefs,
      savedLang: savedLang,
    );
  }

  Widget localizationWrapper(Widget child) {
    return EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
      path: 'assets/langs',
      fallbackLocale: const Locale('en'),
      startLocale: savedLang == AppLanguage.es
          ? const Locale('es')
          : const Locale('en'),
      useOnlyLangCode: true,
      child: child,
    );
  }
}