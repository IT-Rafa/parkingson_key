import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/contact_action_available_provider.dart';
import 'package:parkingson_key/src/models/contacts/contact.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactActionSheet extends ConsumerWidget {
  const ContactActionSheet({
    super.key,
    required this.contact,
    required String message,
  });

  final Contact contact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phone = contact.phone;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _actionTile(
          context: context,
          ref: ref,
          titleKey: 'KEYBOARD_call',
          action: ContactAction.call,
          phone: phone,
          onLaunch: (normalized) =>
              launchUrl(Uri(scheme: 'tel', path: normalized)),
        ),
        _actionTile(
          context: context,
          ref: ref,
          titleKey: 'KEYBOARD_SMS',
          action: ContactAction.sms,
          phone: phone,
          onLaunch: (normalized) =>
              launchUrl(Uri(scheme: 'sms', path: normalized)),
        ),
        _actionTile(
          context: context,
          ref: ref,
          titleKey: 'KEYBOARD_WhatsApp',
          action: ContactAction.whatsapp,
          phone: phone,
          onLaunch: (normalized) =>
              launchUrl(Uri.parse('https://wa.me/$normalized')),
        ),
      ],
    );
  }

  Widget _actionTile({
    required BuildContext context,
    required WidgetRef ref,
    required String titleKey,
    required ContactAction action,
    required String phone,
    required Future<void> Function(String normalized) onLaunch,
  }) {
    final normalized = normalizePhone(phone);
    final asyncCanDo = ref.watch(
      contactActionAvailableProvider(
        (action: action, phone: normalized),
      ),
    );

    final canDo = asyncCanDo.value ?? false;
    print(canDo);
    return ListTile(
      title: Text(titleKey).tr(),
      enabled: canDo,
      onTap: canDo
          ? () async {
              await onLaunch(normalized);
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            }
          : null,
    );
  }
}

String normalizePhone(String phone) {
  return phone.replaceAll(RegExp(r'[^0-9+]'), '');
}
