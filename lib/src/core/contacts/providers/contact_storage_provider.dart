import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/contacts/persistence/contact_storage.dart';

final contactStorageProvider = Provider<ContactStorage>((ref) {
  final storage = ContactStorage();
  storage.init();
  return storage;
});


