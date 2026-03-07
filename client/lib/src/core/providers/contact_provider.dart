import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/persistence/contacts/contact_storage.dart';
import 'package:parkingson_key/src/models/contacts/contact.dart';

final contactStorageProvider = Provider<ContactStorage>((ref) {
  throw UnimplementedError();
});

final contactProvider =
    NotifierProvider<ContactNotifier, List<Contact>>(ContactNotifier.new);

class ContactNotifier extends Notifier<List<Contact>> {
  late ContactStorage _storage;

  @override
  List<Contact> build() {
    _storage = ref.read(contactStorageProvider);
    return _storage.load();
  }

  Future<void> reload() async {
    state = _storage.load();
  }

  Future<void> add(Contact contact) async {
    final updated = [...state, contact];
    await _storage.save(updated);
    state = updated;
  }

  Future<void> update(Contact contact) async {
    final updated =
        state.map((c) => c.id == contact.id ? contact : c).toList();

    await _storage.save(updated);
    state = updated;
  }

  Future<void> delete(String id) async {
    final updated = state.where((c) => c.id != id).toList();
    await _storage.save(updated);
    state = updated;
  }

  Future<void> saveAll(List<Contact> contacts) async {
    await _storage.save(contacts);
    state = contacts;
  }
}