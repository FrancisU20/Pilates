import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pilates/middleware/app_middleware.dart';
import 'package:pilates/providers/user-plan/user_plan_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/widgets/custom_snack_bar.dart';
import 'package:provider/provider.dart';

class ClientNavBar extends StatelessWidget {
  const ClientNavBar({super.key});

  @override
  Widget build(BuildContext context) {
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
            icon: ModalRoute.of(context)!.settings.name == '/dashboard'
                ? const Icon(FontAwesomeIcons.grip)
                : const Icon(FontAwesomeIcons.grip),
            color: ModalRoute.of(context)!.settings.name == '/dashboard'
                ? AppColors.gold100
                : AppColors.white100,
            onPressed: () async {
              await AppMiddleware.updateClienData(context);
              if (!context.mounted) return;
              context.go('/dashboard');
            },
          ),
          IconButton(
            icon: ModalRoute.of(context)!.settings.name == 'class'
                ? const Icon(FontAwesomeIcons.calendarPlus)
                : const Icon(FontAwesomeIcons.calendarPlus),
            color: ModalRoute.of(context)!.settings.name == 'class'
                ? AppColors.gold100
                : AppColors.white100,
            onPressed: () async {
              UserPlanProvider userPlanProvider =
                  Provider.of<UserPlanProvider>(context, listen: false);
              await AppMiddleware.updateClienData(context);
              if (!context.mounted) return;
              if (userPlanProvider.activeUserPlan == null) {
                CustomSnackBar.show(
                    context,
                    'Para acceder al módulo de agendamiento es necesario tener un plan activo.',
                    SnackBarType.error);
                context.go('/dashboard');
                return;
              } else {
                context.go('/dashboard/class');
              }
            },
          ),
          IconButton(
            icon: ModalRoute.of(context)!.settings.name == 'user-class'
                ? const Icon(Icons.calendar_month)
                : const Icon(Icons.calendar_month_outlined),
            color: ModalRoute.of(context)!.settings.name == 'user-class'
                ? AppColors.gold100
                : AppColors.white100,
            onPressed: () {
              context.go('/dashboard/user-class');
            },
          ),
          IconButton(
            icon: ModalRoute.of(context)!.settings.name == 'contact'
                ? const Icon(FontAwesomeIcons.solidComment)
                : const Icon(FontAwesomeIcons.comment),
            color: ModalRoute.of(context)!.settings.name == 'contact'
                ? AppColors.gold100
                : AppColors.white100,
            onPressed: () async {
              await AppMiddleware.updateClienData(context);
              if (!context.mounted) return;
              context.go('/dashboard/contact');
            },
          ),
          IconButton(
            icon: ModalRoute.of(context)!.settings.name == 'my-account'
                ? const Icon(FontAwesomeIcons.userAstronaut)
                : const Icon(FontAwesomeIcons.userAstronaut),
            color: ModalRoute.of(context)!.settings.name == 'my-account'
                ? AppColors.gold100
                : AppColors.white100,
            onPressed: () async {
              await AppMiddleware.updateClienData(context);
              if (!context.mounted) return;
              context.go('/dashboard/my-account');
            },
          ),
        ],
      ),
    );
  }
}
