import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/key_item.dart';

class KeyboardLayoutModel {
  final String id;
  final String name;
  final List<List<KeyItem>> portrait;
  final List<List<KeyItem>> landscape;

  const KeyboardLayoutModel({
    required this.id,
    required this.name,
    required this.portrait,
    required this.landscape,
  });
}
