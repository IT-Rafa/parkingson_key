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

  Future<void> save(List<Contact> contacts) async {
    await _storage.save(contacts);
    state = contacts;
  }

  Future<void> reload() async {
    state = _storage.load();
  }
}