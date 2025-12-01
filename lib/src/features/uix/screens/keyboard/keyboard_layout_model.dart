import 'package:parkingson_key/src/features/uix/screens/keyboard/key_item.dart';

class KeyboardLayoutModel {
  final String id;
  final String name;
  final List<List<KeyItem>> rows;

  const KeyboardLayoutModel({
    required this.id,
    required this.name,
    required this.rows,
  });
}