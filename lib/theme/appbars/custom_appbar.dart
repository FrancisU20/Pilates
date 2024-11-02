import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/theme/colors_palette.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;

  const CustomAppBar({
    super.key,
    this.backgroundColor = ColorsPalette.white, // Valor por defecto
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(FontAwesomeIcons.chevronLeft,
              color: backgroundColor == ColorsPalette.white
                  ? ColorsPalette.black
                  : ColorsPalette.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
