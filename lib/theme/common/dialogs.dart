import 'package:flutter/material.dart';
import 'package:pilates/models/plans/plan_response.dart';
import 'package:pilates/providers/register_provider.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/widgets/buttons.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';
import 'package:provider/provider.dart';

Texts texts = Texts();
Buttons buttons = Buttons();

/// Función reutilizable para mostrar un AlertDialog
Future<void> showComingSoonDialog({
  required BuildContext context,
  VoidCallback? onButtonPressed, // Acción opcional al presionar el botón
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: ColorsPalette.white,
        title: texts.normalText(
          text: 'Próximamente ...',
          color: ColorsPalette.black,
          fontSize: 2.5 * SizeConfig.heightMultiplier,
          fontWeight: FontWeight.w500,
        ),
        content: SizedBox(
          width: 100 * SizeConfig.widthMultiplier,
          height: 35 * SizeConfig.heightMultiplier,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logotipo
              Container(
                width: 100 * SizeConfig.widthMultiplier,
                height: 20 * SizeConfig.heightMultiplier,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo/logo_rectangle.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                width: 100 * SizeConfig.widthMultiplier,
                height: 15 * SizeConfig.heightMultiplier,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    texts.normalText(
                      text:
                          'El módulo estará disponible en la próxima actualización',
                      color: ColorsPalette.black,
                      fontSize: 2 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 2 * SizeConfig.heightMultiplier,
                    ),
                    Center(
                      child: buttons.standart(
                        text: 'Regresar',
                        color: ColorsPalette.greyChocolate,
                        width: 8 * SizeConfig.widthMultiplier,
                        onPressed: onButtonPressed ??
                            () {
                              // Acción predeterminada: cerrar el diálogo
                              Navigator.pop(context);
                            },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> showPaymentMethodDialog({
  required BuildContext context,
  required PlanResponse selectedPlan,
}) async {
  final registerProvider = Provider.of<RegisterProvider>(context, listen: false);
  registerProvider.setSelectedPlan(selectedPlan);

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: ColorsPalette.white,
        title: texts.normalText(
          text: 'Seleccione un método de pago',
          color: ColorsPalette.black,
          fontSize: 2.5 * SizeConfig.heightMultiplier,
          fontWeight: FontWeight.w500,
        ),
        content: SizedBox(
          width: 100 * SizeConfig.widthMultiplier,
          height: 35 * SizeConfig.heightMultiplier,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logotipo de Curves
              Container(
                width: 100 * SizeConfig.widthMultiplier,
                height: 20 * SizeConfig.heightMultiplier,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo/logo_rectangle.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                width: 100 * SizeConfig.widthMultiplier,
                height: 15 * SizeConfig.heightMultiplier,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    texts.normalText(
                      text: 'Usted ha seleccionado el plan ${selectedPlan.name}',
                      color: ColorsPalette.black,
                      fontSize: 2 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(
                      height: 2 * SizeConfig.heightMultiplier,
                    ),
                    texts.normalText(
                      text: 'Nota: Una vez realizado el pago, no se aceptan devoluciones',
                      color: ColorsPalette.black,
                      fontSize: 2 * SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttons.standart(
                  text: 'Transferencia',
                  color: ColorsPalette.greyChocolate,
                  width: 15 * SizeConfig.widthMultiplier,
                  onPressed: () {
                    registerProvider.clearTransferImageFile();
                    Navigator.pushNamed(context, '/transfer');
                  },
                ),
                SizedBox(
                  height: 2 * SizeConfig.heightMultiplier,
                ),
                buttons.standart(
                  text: 'Tarjeta de Crédito',
                  color: ColorsPalette.greyChocolate,
                  width: 15 * SizeConfig.widthMultiplier,
                  onPressed: () {
                    showComingSoonDialog(context: context, onButtonPressed: () {
                      Navigator.pop(context);
                    });
                  },
                ),
              ],
            ),
          )
        ],
      );
    },
  );
}
