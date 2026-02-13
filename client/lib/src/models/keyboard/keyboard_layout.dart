import 'package:parkingson_key/src/models/keyboard/keyboard_item.dart';

class KeyboardLayout {
  final String id;

  final List<List<KeyboardItem>> portrait;
  final List<List<KeyboardItem>> landscape;

  const KeyboardLayout({
    required this.id,
    required this.portrait,
    required this.landscape,
  });
}
