import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/contacts/providers/contact_provider.dart';
import 'package:parkingson_key/src/core/providers/keyboard_profile_provider.dart';
import 'package:parkingson_key/src/core/services/feedback_service.dart';
import 'package:parkingson_key/src/models/contacts/contact.dart';
import 'package:uuid/uuid.dart';

class ContactFormDialog extends ConsumerWidget {
  final Contact? contact; // null = add, != null = edit

  const ContactFormDialog({super.key, this.contact});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController(text: contact?.name ?? '');
    final phoneController = TextEditingController(text: contact?.phone ?? '');
    final emailController = TextEditingController(text: contact?.email ?? '');
    final profile = ref.read(keyboardProfileProvider);

    final isEdit = contact != null;

    return AlertDialog(
      title: Text(
        isEdit ? "SET_CONTACTS_edit" : "SET_CONTACTS_add",
      ).tr(),
      content: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration:
                    InputDecoration(labelText: "SET_CONTACTS_name".tr()),
              ),
              TextField(
                controller: phoneController,
                decoration:
                    InputDecoration(labelText: "SET_CONTACTS_phone".tr()),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: emailController,
                decoration:
                    InputDecoration(labelText: "SET_CONTACTS_email".tr()),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
        ),
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

            final notifier = ref.read(contactProvider.notifier);

            if (isEdit) {
              notifier.update(
                contact!.copyWith(
                  name: name,
                  phone: phone,
                  email: email,
                ),
              );
            } else {
              notifier.add(
                Contact(
                  id: const Uuid().v4(),
                  name: name,
                  phone: phone,
                  email: email,
                ),
              );
            }

            FeedbackService.accept(
              messenger: ScaffoldMessenger.of(context),
              profile: profile,
            );

            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
