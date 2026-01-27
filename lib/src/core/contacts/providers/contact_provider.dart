import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/contacts/persistence/contact_storage.dart';
import 'package:parkingson_key/src/models/contacts/contact.dart';
import 'contact_storage_provider.dart';

final contactProvider =
    NotifierProvider<ContactNotifier, List<Contact>>(ContactNotifier.new);

class ContactNotifier extends Notifier<List<Contact>> {
  late final ContactStorage _storage;

  @override
  List<Contact> build() {
    _storage = ref.read(contactStorageProvider);
    return _storage.load();
  }

  Future<void> add(Contact contact) async {
    final updated = [...state, contact];
    state = updated;
    await _storage.save(updated);
  }

  Future<void> update(Contact contact) async {
    final updated = [
      for (final c in state) if (c.id == contact.id) contact else c
    ];
    state = updated;
    await _storage.save(updated);
  }

  Future<void> delete(String id) async {
    final updated = state.where((c) => c.id != id).toList();
    state = updated;
    await _storage.save(updated);
  }
}
