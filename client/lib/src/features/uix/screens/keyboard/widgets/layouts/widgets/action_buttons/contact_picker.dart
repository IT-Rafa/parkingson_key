import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/contact_storage_provider.dart';
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
           ListTile(
            title: Text(
              "KEYBOARD_contacts",
              style: TextStyle(fontWeight: FontWeight.bold),
            ).tr(),
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
