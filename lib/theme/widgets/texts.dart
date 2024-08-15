import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pilates/theme/colors_palette.dart';

class Texts {
  Widget buttonText(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        textStyle: const TextStyle(
          color: ColorsPalette.textButtonColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget underlineText({
    required String text,
    required VoidCallback onPressed,
    required Color color,
    bool isActive = true,
  }) {
    return TextButton(
      onPressed: isActive ? onPressed : null,
      child: Text(
        text,
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
            decorationColor: color,
          ),
        ),
      ),
    );
  }

  Widget titleText(
      {required String text,
      Color color = ColorsPalette.textColor,
      double fontSize = 24,
      TextAlign textAlign = TextAlign.center,
      FontWeight fontWeight = FontWeight.bold}) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        textStyle: TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            letterSpacing: -0.5,
            height: 0.9),
      ),
      textAlign: textAlign,
    );
  }

  Widget normalText(
      {required String text,
      Color color = ColorsPalette.textColor,
      double fontSize = 16,
      TextAlign textAlign = TextAlign.center,
      FontWeight fontWeight = FontWeight.bold}) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        textStyle: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
      textAlign: textAlign,
    );
  }
}
