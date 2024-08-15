import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/utils/paths/icons.dart';
import 'package:pilates/utils/size_config.dart';
import 'package:pilates/theme/modals/side_menu_modal.dart';

class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsPalette.backgroundColor,
      leading: Builder(
        builder: (context) => IconButton(
          icon: SvgPicture.asset(
            icons.menu,
            width: 10 * SizeConfig.widthMultiplier,
          ),
          onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) => const SideMenuModal(),
          ),
        ),
      ),
    );
  }
}
