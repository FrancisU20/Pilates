import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pilates/middleware/app_middleware.dart';
import 'package:pilates/providers/login/login_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:provider/provider.dart';

class ClientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;

  const ClientAppBar({
    super.key,
    this.backgroundColor = AppColors.white100,
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
          onPressed: () async {
            LoginProvider loginProvider =
                Provider.of<LoginProvider>(context, listen: false);

            if (loginProvider.user == null) {
              context.pop();
            } else {
              await AppMiddleware.updateClientData(context, '/dashboard');
            }
          },
        ),
      ),
    );
  }
}
