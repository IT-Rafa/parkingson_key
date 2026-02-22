import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

enum ContactAction {
  call,
  sms,
  whatsapp,
}

final contactActionAvailableProvider =
    FutureProvider.family<bool, ({ContactAction action, String phone})>(
  (ref, params) async {
    print("param.phone: ${params.phone}, action: ${params.action}");
    if (params.phone.isEmpty) return false;

    late final Uri uri;

    switch (params.action) {
      case ContactAction.call:
        uri = Uri(scheme: 'tel', path: params.phone);
        break;
      case ContactAction.sms:
        uri = Uri(scheme: 'sms', path: params.phone);
        break;
      case ContactAction.whatsapp:
        uri = Uri.parse('https://wa.me/${params.phone}');
        break;
    }

    return canLaunchUrl(uri);
  },
);
