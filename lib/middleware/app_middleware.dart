import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pilates/providers/admin/admin_provider.dart';
import 'package:pilates/providers/nutritional-info/nutritional_info_provider.dart';
import 'package:pilates/providers/user-plan/user_plan_provider.dart';
import 'package:pilates/theme/routes/page_state_provider.dart';
import 'package:pilates/theme/widgets/custom_snack_bar.dart';
import 'package:provider/provider.dart';

class AppMiddleware {
  static Future<void> updateClientData(
      BuildContext context, String route) async {
    //! Providers
    UserPlanProvider userPlanProvider =
        Provider.of<UserPlanProvider>(context, listen: false);
    NutritionalInfoProvider nutritionalInfoProvider =
        Provider.of<NutritionalInfoProvider>(context, listen: false);
    PageStateProvider pageStateProvider =
        Provider.of<PageStateProvider>(context, listen: false);

    //? update del plan
    await userPlanProvider.getUserPlans(context,
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        endDate: DateTime.now().add(const Duration(days: 30)));

    //? view de la informacion nutricional
    if (userPlanProvider.activeUserPlan != null) {
      //? Se obtiene la información nutricional
      if (!context.mounted) return;
      await nutritionalInfoProvider.getUserNutritionalInfo(context);
      if (!context.mounted) return;
      if (nutritionalInfoProvider.nutritionalInfo == null) {
        CustomSnackBar.show(
            context,
            'Hemos detectado que no has llenado tu ficha nutricional. Llena tu ficha para poder disfrutar de la app.',
            SnackBarType.error);
        pageStateProvider.setActiveRoute('/dashboard/nutritional-info');
        context.go('/dashboard/nutritional-info');
      } else {
        if (!context.mounted) return;
        pageStateProvider.setActiveRoute(route);
        context.go(route);
      }
    } else if (userPlanProvider.activeUserPlan == null &&
        route == '/dashboard/class') {
      if (!context.mounted) return;
      CustomSnackBar.show(
          context,
          '¡Ups! No tienes un plan activo. Activa o contrata uno y empieza a agendar tus clases. ¡Te esperamos!',
          SnackBarType.error);
      pageStateProvider.setActiveRoute('/dashboard');
      context.go('/dashboard');
    } else {
      if (!context.mounted) return;
      pageStateProvider.setActiveRoute(route);
      context.go(route);
    }
  }

  static Future<void> updateAdminData(
      BuildContext context, String route) async {
    PageStateProvider pageStateProvider =
        Provider.of<PageStateProvider>(context, listen: false);
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);

    //? Limpia las variables en memoria del provider
    adminProvider.reset();

    //? Obtiene los mese y planes
    adminProvider.getMonths();
    adminProvider.getUsersPlans(context);

    pageStateProvider.setActiveRoute(route);
    context.go(route);
  }
}
