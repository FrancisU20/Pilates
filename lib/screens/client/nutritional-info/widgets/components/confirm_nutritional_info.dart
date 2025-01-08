import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:pilates/middleware/app_middleware.dart';
import 'package:pilates/providers/nutritional-info/nutritional_info_provider.dart';
import 'package:pilates/theme/widgets/custom_button.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/size_config.dart';
import 'package:provider/provider.dart';

class ConfirmNutritionalInfo extends StatelessWidget {
  const ConfirmNutritionalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.scaleWidth(5),
        vertical: SizeConfig.scaleHeight(2),
      ),
      decoration: BoxDecoration(
        color: AppColors.white200,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.black100.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      height: SizeConfig.scaleHeight(40),
      child: Column(
        children: [
          Center(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: SizeConfig.scaleWidth(60),
                height: SizeConfig.scaleHeight(12),
                decoration: BoxDecoration(
                  color: AppColors.green200,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.clipboardCheck,
                      color: AppColors.white100,
                      size: SizeConfig.scaleHeight(3),
                    ),
                    SizedBox(height: SizeConfig.scaleHeight(1)),
                    CustomText(
                      text: 'Confirma tu información nutricional',
                      color: AppColors.white100,
                      fontSize: SizeConfig.scaleText(2),
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: SizeConfig.scaleHeight(2)),
          CustomText(
            text:
                'Por favor, verifica que la información nutricional que ingresaste es correcta. Una vez confirmada, se enviará a tu nutricionista para su revisión.',
            fontSize: SizeConfig.scaleText(2),
            color: AppColors.green200,
            fontWeight: FontWeight.w500,
            maxLines: 8,
            textAlign: TextAlign.justify,
          ),
          const Spacer(),
          CustomButton(
            text: 'Guardar Ficha',
            onPressed: () async {
              NutritionalInfoProvider nutritionalInfoProvider =
                  Provider.of<NutritionalInfoProvider>(context, listen: false);

              //? Si la informacion es correcta, se guarda
              await nutritionalInfoProvider.createNutritionalInfo(context);

              if (!context.mounted) return;
              //? Actualiza la informacion del cliente
              await AppMiddleware.updateClienData(context);

              //? Redirige al dashboard
              if (!context.mounted) return;
              context.go('/dashboard');
            },
            color: AppColors.brown200,
          ),
        ],
      ),
    );
  }
}
