import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/core/providers/keyboard_profile_provider.dart';
import 'package:parkingson_key/src/core/services/feedback_service.dart';
import 'package:parkingson_key/src/core/services/whatsapp_service.dart';
import 'package:parkingson_key/src/core/contacts/providers/contact_provider.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/keyboard_body/widgets/keyboard_row/widgets/utils/accept_on_hold.dart';

class ContactPicker extends ConsumerWidget {
  final String message;

  const ContactPicker({super.key, required this.message});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contacts =
        ref.watch(contactProvider).where((c) => c.whatsappEnabled).toList();
    final profile = ref.watch(keyboardProfileProvider);

    return SafeArea(
      child: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          final accept = AcceptOnHold();

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (_) {
              accept.start(
                onAccept: () async {
                  FeedbackService.accept(
                    messenger: ScaffoldMessenger.of(context),
                    profile: profile,
                  );

                  final ok = await WhatsAppService.sendMessage(
                    contact.phone,
                    message,
                  );

                  if (!ok && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'WhatsApp no está disponible en este dispositivo',
                        ),
                      ),
                    );
                  }

                  if (context.mounted) Navigator.pop(context);
                },
                duration: profile.acceptHoldDuration,
              );
            },
            onTapUp: (_) => accept.cancel(),
            onTapCancel: () => accept.cancel(),
            child: ListTile(
              title: Text(contact.name),
            ),
          );
        },
      ),
    );
  }
}
