import 'package:flutter/material.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';

class ErrorSnackBar {
  final Texts texts = Texts();

  void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: texts.normalText(
          text: message.replaceAll('Exception: ', ''),
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.start,
          fontSize: 2 * SizeConfig.heightMultiplier,
          color: ColorsPalette.white,
        ),
        backgroundColor: ColorsPalette.redAged,
      ),
    );
  }
}
