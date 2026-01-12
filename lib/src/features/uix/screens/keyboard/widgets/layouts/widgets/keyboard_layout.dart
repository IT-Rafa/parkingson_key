import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/utils/keyboard_item.dart';

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
