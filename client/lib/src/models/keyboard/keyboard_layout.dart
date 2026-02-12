
import 'package:parkingson_key/src/models/keyboard/keyboard_item.dart';
import 'package:shared/models/keyboard_layout_dto.dart';

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

// Mapper desde DTO (shared) a modelo de cliente
KeyboardLayout mapFromDto(
  KeyboardLayoutDto dto,
  KeyboardItemRegistry registry,
) {
  return KeyboardLayout(
    id: dto.id,
    portrait: dto.portrait
        .map((row) => row.map((id) => registry.get(id)).toList())
        .toList(),
    landscape: dto.landscape
        .map((row) => row.map((id) => registry.get(id)).toList())
        .toList(),
  );
}
