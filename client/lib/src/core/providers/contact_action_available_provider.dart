import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkingson_key/src/features/uix/screens/keyboard/widgets/layouts/widgets/action_buttons/contact_action_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

enum ContactAction {
  call,
  sms,
  whatsapp,
}

final contactActionAvailableProvider =
    FutureProvider.family<bool, ({ContactAction action, String phone})>(
  (ref, params) async {
    final phone = normalizePhone(params.phone);
    if (phone.isEmpty) return false;

    late final Uri uri;

    switch (params.action) {
      case ContactAction.call:
        uri = Uri(scheme: 'tel', path: phone);
        break;
      case ContactAction.sms:
        uri = Uri(scheme: 'sms', path: phone);
        break;
      case ContactAction.whatsapp:
        uri = Uri.parse('https://wa.me/$phone');
        break;
    }

    return canLaunchUrl(uri);
  },
);
