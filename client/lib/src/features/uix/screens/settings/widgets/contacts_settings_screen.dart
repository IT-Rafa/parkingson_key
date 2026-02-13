import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/keyboard_profile_provider.dart';
import 'package:parkingson_key/src/core/services/feedback_service.dart';
import 'package:parkingson_key/src/core/contacts/providers/contact_provider.dart';
import 'package:parkingson_key/src/models/contacts/contact.dart';
import 'package:uuid/uuid.dart';

class ContactsSettingsScreen extends ConsumerWidget {
  const ContactsSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contacts = ref.watch(contactProvider);
    final profile = ref.watch(keyboardProfileProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Contactos")),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];

          return ListTile(
            title: Text(contact.name),
            subtitle: Text(contact.phone),
            onTap: () async {
              // Vibración + TTS al tocar
              FeedbackService.accept(
                messenger: ScaffoldMessenger.of(context),
                profile: profile,
              );
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    _showEditContactDialog(context, ref, contact);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    ref.read(contactProvider.notifier).delete(contact.id);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddContactDialog(context, ref),
      ),
    );
  }

  void _showAddContactDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final profile = ref.read(keyboardProfileProvider);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Añadir contacto"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Teléfono"),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("Cancelar"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text("Guardar"),
            onPressed: () {
              final name = nameController.text.trim();
              final phone = phoneController.text.trim();
              if (name.isEmpty || phone.isEmpty) return;

              final newContact = Contact(
                id: const Uuid().v4(),
                name: name,
                phone: phone,
              );

              ref.read(contactProvider.notifier).add(newContact);

              // Feedback háptico
              FeedbackService.accept(
                messenger: ScaffoldMessenger.of(context),
                profile: profile,
              );

              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showEditContactDialog(BuildContext context, WidgetRef ref, Contact contact) {
    final nameController = TextEditingController(text: contact.name);
    final phoneController = TextEditingController(text: contact.phone);
    final profile = ref.read(keyboardProfileProvider);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Editar contacto"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: "Teléfono"),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("Cancelar"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text("Guardar"),
            onPressed: () {
              final name = nameController.text.trim();
              final phone = phoneController.text.trim();
              if (name.isEmpty || phone.isEmpty) return;

              final updated = contact.copyWith(name: name, phone: phone);
              ref.read(contactProvider.notifier).update(updated);

              // Feedback háptico
              FeedbackService.accept(
                messenger: ScaffoldMessenger.of(context),
                profile: profile,
              );

              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
