import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/contact_provider.dart';
import 'package:parkingson_key/src/core/providers/keyboard_profile_provider.dart';
import 'package:parkingson_key/src/core/services/feedback_service.dart';
import 'package:parkingson_key/src/models/contacts/contact.dart';
import 'package:uuid/uuid.dart';

class ContactFormDialog extends ConsumerStatefulWidget {
  final Contact? contact;

  const ContactFormDialog({super.key, this.contact});

  @override
  ConsumerState<ContactFormDialog> createState() =>
      _ContactFormDialogState();
}

class _ContactFormDialogState
    extends ConsumerState<ContactFormDialog> {

  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    nameController =
        TextEditingController(text: widget.contact?.name ?? '');
    phoneController =
        TextEditingController(text: widget.contact?.phone ?? '');
    emailController =
        TextEditingController(text: widget.contact?.email ?? '');
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.contact != null;
    final profile = ref.read(keyboardProfileProvider);

    return AlertDialog(
      title: Text(
        isEdit ? "SET_CONTACTS_edit" : "SET_CONTACTS_add",
      ).tr(),
      content: Scrollbar(
        controller: scrollController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: scrollController,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "SET_CONTACTS_name".tr(),
                ),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: "SET_CONTACTS_phone".tr(),
                ),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "SET_CONTACTS_email".tr(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("SET_CONTACTS_cancel").tr(),
        ),
        TextButton(
          onPressed: () {
            final name = nameController.text.trim();
            final phone = phoneController.text.trim();
            final email = emailController.text.trim();

            if (name.isEmpty || phone.isEmpty) return;

            final notifier = ref.read(contactProvider.notifier);

            if (isEdit) {
              notifier.update(
                widget.contact!.copyWith(
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
          child: const Text("SET_CONTACTS_save").tr(),
        ),
      ],
    );
  }
}