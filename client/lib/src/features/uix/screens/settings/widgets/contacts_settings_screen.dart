import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/contact_provider.dart';
import 'package:parkingson_key/src/core/providers/keyboard_profile_provider.dart';
import 'package:parkingson_key/src/core/services/feedback_service.dart';
import 'package:parkingson_key/src/features/uix/screens/settings/widgets/contact_form_dialog.dart';

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
                      showDialog(
                        context: context,
                        builder: (_) => ContactFormDialog(contact: contact),
                      );
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
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => const ContactFormDialog(),
            );
          },
        ),
      ),
    );
  }
}
