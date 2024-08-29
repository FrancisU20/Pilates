import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/theme/colors_palette.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;

  const CustomAppBar({
    super.key,
    this.backgroundColor = ColorsPalette.backgroundColor, // Valor por defecto
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor, // Utiliza el color proporcionado
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(FontAwesomeIcons.chevronLeft,
              color: backgroundColor == ColorsPalette.backgroundColor
                  ? Colors.black
                  : Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
