import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/size_config.dart';

class PlanStatusDisclaimer extends StatelessWidget {
  const PlanStatusDisclaimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white200,
      child: Container(
        padding: EdgeInsets.all(SizeConfig.scaleHeight(2)),
        child: Column(
          children: [
            Center(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: SizeConfig.scaleWidth(100),
                  height: SizeConfig.scaleHeight(10),
                  decoration: BoxDecoration(
                    color: AppColors.green200,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.circleCheck,
                        color: AppColors.white100,
                        size: SizeConfig.scaleHeight(3),
                      ),
                      SizedBox(height: SizeConfig.scaleHeight(1)),
                      CustomText(
                        text: 'Plan creado con éxito',
                        color: AppColors.white100,
                        fontSize:SizeConfig.scaleText(2),
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.scaleHeight(2)),
            CustomText(
              text:
                  'Estamos validando tu transferencia. Mientras tanto, tu plan permanecerá en estado inactivo. Una vez que confirmemos el pago, activaremos tu suscripción. Si tienes alguna duda, pulsa el botón de abajo para comunicarte con nosotros a través de WhatsApp. ¡Estamos aquí para ayudarte!',
              fontSize:SizeConfig.scaleText(1.8),
              color: AppColors.green200,
              fontWeight: FontWeight.w500,
              maxLines: 8,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
