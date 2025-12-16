import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_item.dart';

class KeyboardLayout {
  final List<List<KeyboardItem>> portrait;
  final List<List<KeyboardItem>> landscape;

  const KeyboardLayout({
    required this.portrait,
    required this.landscape,
    required List<List<KeyboardItem>> layout,
  });
}
