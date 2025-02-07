import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      height: SizeConfig.scaleHeight(30),
      child: Column(
        children: [
          Center(
            child: GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.clipboardCheck,
                    color: AppColors.grey100,
                    size: SizeConfig.scaleHeight(3),
                  ),
                  SizedBox(height: SizeConfig.scaleHeight(1)),
                  CustomText(
                    text: '¡Estás a punto de guardar tus datos!',
                    color: AppColors.grey200,
                    fontSize: SizeConfig.scaleText(2),
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: SizeConfig.scaleHeight(2)),
          CustomText(
            text:
                'Revisa que la información nutricional sea correcta. Una vez confirmada, la enviaremos a tu nutricionista para su revisión.',
            fontSize: SizeConfig.scaleText(1.8),
            color: AppColors.grey100,
            fontWeight: FontWeight.w500,
            maxLines: 8,
            textAlign: TextAlign.justify,
          ),
          const Spacer(),
          CustomButton(
            text: 'Confirmar y Guardar',
            onPressed: () async {
              NutritionalInfoProvider nutritionalInfoProvider =
                  Provider.of<NutritionalInfoProvider>(context, listen: false);

              //? Si la informacion es correcta, se guarda
              await nutritionalInfoProvider.createNutritionalInfo(context);

              if (!context.mounted) return;
              //? Actualiza la informacion del cliente y lo redirige al dashboard
              await AppMiddleware.updateClientData(context, '/dashboard');
            },
            color: AppColors.green200,
          ),
        ],
      ),
    );
  }
}
