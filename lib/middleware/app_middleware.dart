import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pilates/providers/nutritional-info/nutritional_info_provider.dart';
import 'package:pilates/providers/user-plan/user_plan_provider.dart';
import 'package:pilates/theme/widgets/custom_snack_bar.dart';
import 'package:provider/provider.dart';

class AppMiddleware {
  static Future<void> updateClienData(BuildContext context) async {
    //! Providers
    UserPlanProvider userPlanProvider =
        Provider.of<UserPlanProvider>(context, listen: false);
    NutritionalInfoProvider nutritionalInfoProvider =
        Provider.of<NutritionalInfoProvider>(context, listen: false);

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
        context.go('/dashboard/nutritional-info');
      } 
    }
  }
}
