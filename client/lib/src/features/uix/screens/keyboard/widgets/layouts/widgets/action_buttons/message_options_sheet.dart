import 'package:flutter/material.dart';
import 'package:parkingson_key/src/core/services/whatsapp_service.dart';
import 'package:parkingson_key/src/models/contacts/contact.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageOptionsSheet extends StatefulWidget {
  final Contact contact;
  final String message;

  const MessageOptionsSheet({
    super.key,
    required this.contact,
    required this.message,
  });

  @override
  State<MessageOptionsSheet> createState() => _MessageOptionsSheetState();
}

class _MessageOptionsSheetState extends State<MessageOptionsSheet> {
  @override
  Widget build(BuildContext context) {
    final canWhatsapp = widget.contact.whatsappEnabled;
    final canEmail =
        widget.contact.email != null && widget.contact.email!.isNotEmpty;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text("WhatsApp"),
            enabled: canWhatsapp,
            onTap: canWhatsapp
                ? () async {
                    await WhatsAppService.sendMessage(
                      widget.contact.phone,
                      widget.message,
                    );

                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                : null,
          ),
          ListTile(
            title: const Text("Email"),
            enabled: canEmail,
            onTap: canEmail
                ? () async {
                    final uri = Uri(
                      scheme: 'mailto',
                      path: widget.contact.email,
                      queryParameters: {
                        'body': widget.message,
                      },
                    );

                    await launchUrl(uri);

                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
