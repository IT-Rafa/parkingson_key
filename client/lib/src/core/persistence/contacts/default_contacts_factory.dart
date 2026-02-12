import 'package:parkingson_key/src/models/contacts/contact.dart';

class DefaultContactsFactory {
  static List<Contact> create() {
    return [
      Contact(
        id: 'caregiver',
        name: 'Cuidador',
        phone: '34600000001',
      ),
      Contact(
        id: 'family',
        name: 'Familia',
        phone: '34600000002',
      ),
      Contact(
        id: 'emergency',
        name: 'Emergencias',
        phone: '112',
      ),
    ];
  }
}