import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/providers/user-plan/user_plan_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/icons_paths.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/components/client/client_menu.dart';
import 'package:provider/provider.dart';

class ClientHomeBar extends StatelessWidget implements PreferredSizeWidget {
  const ClientHomeBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white100,
      scrolledUnderElevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: SvgPicture.asset(
            iconsPaths.menu,
            width: SizeConfig.scaleWidth(10),
          ),
          onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) => const ClientMenu(),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            FontAwesomeIcons.rotateLeft,
            color: AppColors.grey200,
          ),
          onPressed: () async {
            await Provider.of<UserPlanProvider>(context, listen: false).getUserPlans(
                context,
                startDate: DateTime.now().subtract(const Duration(days: 30)),
                endDate: DateTime.now().add(const Duration(days: 30)));
          },
        ),
      ],
    );
  }
}
