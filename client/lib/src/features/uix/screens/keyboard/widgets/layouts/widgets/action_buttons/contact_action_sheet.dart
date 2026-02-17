import 'package:flutter/material.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/action_buttons/message_options_sheet.dart';
import 'package:parkingson_key/src/models/contacts/contact.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactActionSheet extends StatelessWidget {
  final Contact contact;
  final String message;

  const ContactActionSheet({
    super.key,
    required this.contact,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final canCall = contact.callEnabled && contact.phone.isNotEmpty;

    final canWhatsapp = contact.whatsappEnabled;

    final canEmail = contact.email != null && contact.email!.isNotEmpty;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text("Llamar"),
            enabled: canCall,
            onTap: canCall
                ? () async {
                    final uri = Uri.parse("tel:${contact.phone}");
                    await launchUrl(uri);
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                : null,
          ),
          ListTile(
            title: const Text("Enviar mensaje"),
            enabled: canWhatsapp || canEmail,
            onTap: (canWhatsapp || canEmail)
                ? () {
                    Navigator.pop(context);
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => MessageOptionsSheet(
                        contact: contact,
                        message: message,
                      ),
                    );
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
