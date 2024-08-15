import 'package:flutter/material.dart';
import 'package:pilates/theme/widgets/texts.dart';

class ErrorSnackBar {
  final Texts texts = Texts();

  void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: texts.normalText(
          text: message.replaceAll('Exception: ', ''),
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.start,
          fontSize: 16,
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 207, 117, 117),
      ),
    );
  }
}
