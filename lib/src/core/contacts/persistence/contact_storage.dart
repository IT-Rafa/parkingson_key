import 'package:hive/hive.dart';
import 'package:parkingson_key/src/models/contacts/contact.dart';

class ContactStorage {
  static const _boxName = 'contacts_box';
  static const _key = 'contacts';

  late Box<List> _box;

  Future<void> init() async {
    _box = await Hive.openBox<List>(_boxName);
  }

  bool get isEmpty => !_box.containsKey(_key) || _box.get(_key)!.isEmpty;

  List<Contact> load() {
    final data = _box.get(_key);
    if (data == null) return [];
    return data.cast<Contact>();
  }

  Future<void> save(List<Contact> contacts) async {
    await _box.put(_key, contacts);
  }
}
