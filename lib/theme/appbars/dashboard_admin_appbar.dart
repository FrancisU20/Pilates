import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/modals/side_admin_menu_modal.dart';
import 'package:pilates/utils/icons_paths.dart';
import 'package:pilates/utils/size_config.dart';

class DashboardAdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAdminAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorsPalette.white,
      scrolledUnderElevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: SvgPicture.asset(
            iconsPaths.menu,
            width: 10 * SizeConfig.widthMultiplier,
          ),
          onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) => const SideAdminMenuModal(),
          ),
        ),
      ),
    );
  }
}
