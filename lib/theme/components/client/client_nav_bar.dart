import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/middleware/app_middleware.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/routes/page_state_provider.dart';
import 'package:provider/provider.dart';

class ClientNavBar extends StatelessWidget {
  const ClientNavBar({super.key});

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
                icon: pageStateProvider.activeRoute == '/dashboard/class'
                    ? const Icon(FontAwesomeIcons.calendarPlus)
                    : const Icon(FontAwesomeIcons.calendarPlus),
                color: pageStateProvider.activeRoute == '/dashboard/class'
                    ? AppColors.gold100
                    : AppColors.white100,
                onPressed: () async {
                  await AppMiddleware.updateClientData(
                      context, '/dashboard/class');
                },
              ),
              IconButton(
                icon: pageStateProvider.activeRoute == '/dashboard/user-class'
                    ? const Icon(FontAwesomeIcons.calendarCheck)
                    : const Icon(FontAwesomeIcons.calendarCheck),
                color: pageStateProvider.activeRoute == '/dashboard/user-class'
                    ? AppColors.gold100
                    : AppColors.white100,
                onPressed: () async {
                  await AppMiddleware.updateClientData(
                      context, '/dashboard/user-class');
                },
              ),
              IconButton(
                icon: pageStateProvider.activeRoute == '/dashboard'
                    ? Icon(FontAwesomeIcons.house,
                        size: SizeConfig.scaleHeight(4))
                    : Icon(FontAwesomeIcons.house,
                        size: SizeConfig.scaleHeight(4)),
                color: pageStateProvider.activeRoute == '/dashboard'
                    ? AppColors.gold100
                    : AppColors.white100,
                onPressed: () async {
                  await AppMiddleware.updateClientData(context, '/dashboard');
                },
              ),
              IconButton(
                icon: pageStateProvider.activeRoute == '/dashboard/contact'
                    ? const Icon(FontAwesomeIcons.solidComment)
                    : const Icon(FontAwesomeIcons.solidComment),
                color: pageStateProvider.activeRoute == '/dashboard/contact'
                    ? AppColors.gold100
                    : AppColors.white100,
                onPressed: () async {
                  await AppMiddleware.updateClientData(
                      context, '/dashboard/contact');
                },
              ),
              IconButton(
                icon: pageStateProvider.activeRoute == '/dashboard/my-account'
                    ? const Icon(FontAwesomeIcons.userAstronaut)
                    : const Icon(FontAwesomeIcons.userAstronaut),
                color: pageStateProvider.activeRoute == '/dashboard/my-account'
                    ? AppColors.gold100
                    : AppColors.white100,
                onPressed: () async {
                  await AppMiddleware.updateClientData(
                      context, '/dashboard/my-account');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
