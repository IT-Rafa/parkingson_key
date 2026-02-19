import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/contacts/providers/contact_provider.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/action_buttons/contact_action_sheet.dart';

class ContactPicker extends ConsumerWidget {
  final String message;

  const ContactPicker({super.key, required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contacts = ref.watch(contactProvider);

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ListTile(
            title: Text(
              "Contactos",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(height: 1),
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];

                return ListTile(
                  title: Text(contact.name),
                  onTap: () {
                    Navigator.pop(context);

                    showModalBottomSheet(
                      context: context,
                      builder: (_) => ContactActionSheet(
                        contact: contact,
                        message: message,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
