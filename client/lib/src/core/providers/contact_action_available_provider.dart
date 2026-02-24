import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/models/contacts/contact.dart';
import 'package:url_launcher/url_launcher.dart';

enum ContactAction {
  call,
  sms,
  whatsapp,
  email,
}

final contactActionAvailableProvider =
    FutureProvider.family<bool, ({ContactAction action, Contact contact})>(
  (ref, params) async {
    late final Uri uri;

    switch (params.action) {
      case ContactAction.call:
        if (params.contact.phone.isEmpty) return false;
        uri = Uri(scheme: 'tel', path: params.contact.phone);
        break;
      case ContactAction.sms:
        if (params.contact.phone.isEmpty) return false;

        uri = Uri(scheme: 'sms', path: params.contact.phone);
        break;
      case ContactAction.whatsapp:
        if (params.contact.phone.isEmpty) return false;

        uri = Uri.parse('https://wa.me/${params.contact.phone}');
        break;
      case ContactAction.email:
        if (params.contact.email!.isEmpty) return false;
        uri = Uri(
            scheme: 'mailto',
            path: params.contact.email,
            queryParameters: {'subject': 'Example'});
        break;
    }

    return canLaunchUrl(uri);
  },
);
