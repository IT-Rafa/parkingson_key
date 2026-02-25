import 'package:easy_localization/easy_localization.dart';
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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("SETTINGS_contacts").tr()),
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
      ),
    );
  }

  void _showAddContactDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();
    final profile = ref.read(keyboardProfileProvider);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("SET_CONTACTS_add").tr(),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "SET_CONTACTS_name".tr()),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "SET_CONTACTS_phone".tr()),
              keyboardType: TextInputType.phone,
            ),
                        TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "SET_CONTACTS_email".tr()),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("SET_CONTACTS_cancel").tr(),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text("SET_CONTACTS_save").tr(),
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

  void _showEditContactDialog(
      BuildContext context, WidgetRef ref, Contact contact) {
    final nameController = TextEditingController(text: contact.name);
    final phoneController = TextEditingController(text: contact.phone);
    final emailController = TextEditingController(text: contact.email);
    final profile = ref.read(keyboardProfileProvider);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("SET_CONTACTS_edit").tr(),
        insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              
              controller: nameController,
              decoration: InputDecoration(labelText: "SET_CONTACTS_name".tr()),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "SET_CONTACTS_phone".tr()),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "SET_CONTACTS_email".tr()),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("SET_CONTACTS_cancel").tr(),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text("SET_CONTACTS_save").tr(),
            onPressed: () {
              final name = nameController.text.trim();
              final phone = phoneController.text.trim();
              final email = emailController.text.trim();
              if (name.isEmpty || phone.isEmpty) return;

              final updated = contact.copyWith(
                name: name,
                phone: phone,
                email: email,
              );
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
