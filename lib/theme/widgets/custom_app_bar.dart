import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/utils/custom_navigator.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final bool toDashboard;

  const CustomAppBar({
    super.key,
    this.backgroundColor = AppColors.white100, // Valor por defecto
    this.toDashboard = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      scrolledUnderElevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(FontAwesomeIcons.chevronLeft,
              color: backgroundColor == AppColors.white100
                  ? AppColors.black100
                  : AppColors.white100),
          onPressed: () => toDashboard
              ? customNavigator(context, '/dashboard', clearStack: true)
              : Navigator.pop(context),
        ),
      ),
    );
  }
}
