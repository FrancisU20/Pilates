import 'package:flutter/material.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';

class Buttons {
  Texts texts = Texts();
  Widget standart({
    required String text,
    required VoidCallback onPressed,
    required Color color,
    double width = 60,
    double height = 5,
    bool isActive = true,
  }) {
    return SizedBox(
      width: width * SizeConfig.widthMultiplier,
      height: height * SizeConfig.heightMultiplier,
      child: ElevatedButton(
        onPressed: isActive ? onPressed : null,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(color),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), // radio del borde
              side: BorderSide(color: color), // color y grosor del borde
            ),
          ),
        ),
        child: texts.buttonText(text),
      ),
    );
  }

  Widget icon({
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
    bool isActive = true,
  }) {
    return IconButton(
      onPressed: isActive ? onPressed : null,
      icon: Icon(icon),
      color: color,
    );
  }

  Widget iconText({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
    required Color color,
    bool isActive = true,
  }) {
    return SizedBox(
      width: 60 * SizeConfig.widthMultiplier,
      height: 5 * SizeConfig.heightMultiplier,
      child: TextButton.icon(
        onPressed: isActive ? onPressed : null,
        icon: Icon(icon, color: ColorsPalette.white),
        label: texts.buttonText(text),
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(color),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), // radio del borde
              side: BorderSide(color: color), // color y grosor del borde
            ),
          ),
        ),
      ),
    );
  }

  Widget alterIconText({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
    required Color color,
    bool isActive = true,
  }) {
    return SizedBox(
      width: 60 * SizeConfig.widthMultiplier,
      height: 5 * SizeConfig.heightMultiplier,
      child: TextButton(
        onPressed: isActive ? onPressed : null,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(color),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0), // radio del borde
              side: BorderSide(color: color), // color y grosor del borde
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            texts.buttonText(text),
            const SizedBox(width: 8), // Espacio entre el texto y el ícono
            Icon(icon, color: ColorsPalette.white),
          ],
        ),
      ),
    );
  }

  // Crea un undeline text button
  Widget underlineText({
    required String text,
    required VoidCallback onPressed,
    required Color color,
    bool isActive = true,
  }) {
    return TextButton(
      onPressed: isActive ? onPressed : null,
      child: texts.underlineText(
        text: text,
        onPressed: onPressed,
        color: color,
        isActive: isActive,
      ),
    );
  }

  Widget iconTextUnderline({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
    required Color color,
    bool isActive = true,
  }) {
    return TextButton(
      onPressed: isActive ? onPressed : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 0.5), // Espacio entre el ícono y el texto
          texts.underlineText(
            text: text,
            onPressed: onPressed,
            color: color,
            isActive: isActive,
          ),
        ],
      ),
    );
  }
}
