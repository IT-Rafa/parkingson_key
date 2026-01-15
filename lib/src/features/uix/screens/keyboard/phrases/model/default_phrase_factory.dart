import 'package:parkingson_key/src/core/providers/app_language_enum.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/phrases/model/phrase_node.dart';

class DefaultPhraseFactory {
  static List<PhraseNode> create(AppLanguage lang) {
    switch (lang) {
      case AppLanguage.es:
        return _spanish();
      case AppLanguage.en:
        return _english();
    }
  }
}
