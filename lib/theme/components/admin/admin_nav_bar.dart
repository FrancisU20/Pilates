import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/middleware/app_middleware.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/routes/page_state_provider.dart';
import 'package:provider/provider.dart';

class AdminNavBar extends StatelessWidget {
  const AdminNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PageStateProvider>(
      builder: (context, pageStateProvider, _) {
        return Container(
          margin: EdgeInsets.all(SizeConfig.scaleHeight(2)),
          decoration: BoxDecoration(
            color: AppColors.black100,
            borderRadius: BorderRadius.circular(50),
          ),
          height: SizeConfig.scaleHeight(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: pageStateProvider.activeRoute ==
                        '/admin-dashboard/user-class'
                    ? const Icon(FontAwesomeIcons.calendarCheck)
                    : const Icon(FontAwesomeIcons.calendarCheck),
                color: pageStateProvider.activeRoute ==
                        '/admin-dashboard/user-class'
                    ? AppColors.gold100
                    : AppColors.white100,
                onPressed: () async {
                  await AppMiddleware.updateAdminData(
                      context, '/admin-dashboard/user-class');
                },
              ),
              IconButton(
                icon: pageStateProvider.activeRoute == '/admin-dashboard'
                    ? Icon(FontAwesomeIcons.house,
                        size: SizeConfig.scaleHeight(4))
                    : Icon(FontAwesomeIcons.house,
                        size: SizeConfig.scaleHeight(4)),
                color: pageStateProvider.activeRoute == '/admin-dashboard'
                    ? AppColors.gold100
                    : AppColors.white100,
                onPressed: () async {
                  await AppMiddleware.updateAdminData(
                      context, '/admin-dashboard');
                },
              ),
              IconButton(
                icon: pageStateProvider.activeRoute == '/admin-dashboard/users'
                    ? const Icon(FontAwesomeIcons.addressBook)
                    : const Icon(FontAwesomeIcons.addressBook),
                color: pageStateProvider.activeRoute == '/admin-dashboard/users'
                    ? AppColors.gold100
                    : AppColors.white100,
                onPressed: () async {
                  await AppMiddleware.updateAdminData(
                      context, '/admin-dashboard/users');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
