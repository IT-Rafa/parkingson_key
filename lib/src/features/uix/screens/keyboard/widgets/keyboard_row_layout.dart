import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/keyboard_item.dart';

class KeyboardRowLayout {
  final List<KeyboardItem> landscape;
  final List<KeyboardItem> portrait;

  const KeyboardRowLayout({
    required this.landscape,
    required this.portrait,
  });
}
