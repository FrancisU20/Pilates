import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class WhatsAppLauncher {
  whatsappRedirect({required String message}) async {
    Uri url = Uri.parse(Platform.isAndroid
        ? 'whatsapp://send?phone=593998630405&text=$message'
        : 'https://api.whatsapp.com/send?phone=593998630405&text=$message');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}

WhatsAppLauncher whatsappServices = WhatsAppLauncher();
