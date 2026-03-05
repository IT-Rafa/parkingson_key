import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/persistence/contacts/contact_storage.dart';

import 'package:hive/hive.dart';
import 'package:parkingson_key/src/models/contacts/contact.dart';

class ContactStorage {
  static const _boxName = 'contacts_box';
  static const _key = 'contacts';

  late final Box<List> _box;
  bool _initialized = false;

  /// Inicializa la caja Hive, solo una vez
  Future<void> init() async {
    if (_initialized) return;

    if (!Hive.isBoxOpen(_boxName)) {
      _box = await Hive.openBox<List>(_boxName);
    } else {
      _box = Hive.box<List>(_boxName);
    }

    _initialized = true;
  }

  /// Comprueba si no hay contactos guardados
  bool get isEmpty => !_box.containsKey(_key) || _box.get(_key)!.isEmpty;

  /// Carga todos los contactos
  List<Contact> load() {
    final data = _box.get(_key);
    if (data == null) return [];
    return data.cast<Contact>();
  }

  /// Guarda todos los contactos
  Future<void> save(List<Contact> contacts) async {
    await _box.put(_key, contacts);
  }
}

