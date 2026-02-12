import 'package:parkingson_key/src/core/providers/app_language_enum.dart';
import 'package:parkingson_key/src/models/phrase/phrase_node.dart';

class DefaultPhraseFactory {
  static List<PhraseNode> create(AppLanguage lang) {
    switch (lang) {
      case AppLanguage.es:
        return _spanish();
      case AppLanguage.en:
        return _english();
    }
  }

  static List<PhraseNode> _spanish() {
    return [
      PhraseNode(
        id: 'food',
        title: 'Comida',
        isCategory: true,
        children: [
          PhraseNode(
            id: 'food_phrases_1',
            title: 'Tengo hambre',
            isCategory: false,
          ),
          PhraseNode(
            id: 'food_phrases_2',
            title: 'Quiero beber agua',
            isCategory: false,
          ),
        ],
      ),
      PhraseNode(
        id: 'bed',
        title: 'Cama',
        isCategory: true,
        children: [
          PhraseNode(id: 'bed_1', title: 'Quiero tumbarme', isCategory: false),
        ],
      ),
      PhraseNode(id: 'posture', title: 'Postura', isCategory: true),
    ];
  }

  static List<PhraseNode> _english() {
    return [
      PhraseNode(
        id: 'food',
        title: 'Food',
        isCategory: true,
        children: [
          PhraseNode(
            id: 'food_phrases_1',
            title: 'I am hungry',
            isCategory: false,
          ),
          PhraseNode(
            id: 'food_phrases_2',
            title: 'I want water',
            isCategory: false,
          ),
        ],
      ),
      PhraseNode(
        id: 'bed',
        title: 'Bed',
        isCategory: true,
        children: [
          PhraseNode(
            id: 'bed_1',
            title: 'I want to lie down',
            isCategory: false,
          ),
        ],
      ),
      PhraseNode(id: 'posture', title: 'Posture', isCategory: true),
    ];
  }
}
