import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class InstagramLauncher {
  instagramRedirect({required String username}) async {
    Uri url = Uri.parse(Platform.isAndroid
        ? 'instagram://user?username=$username'
        : 'https://www.instagram.com/$username/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}

InstagramLauncher instagramServices = InstagramLauncher();
