import 'package:url_launcher/url_launcher.dart';

class WhatsAppService {
  static Future<bool> sendMessage(String phone, String message) async {
    final url = Uri.parse(
      'https://wa.me/$phone?text=${Uri.encodeComponent(message)}',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
      return true;
    } else {
      return false;
    }
  }
}
