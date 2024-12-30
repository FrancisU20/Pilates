import 'package:flutter/material.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';

class Step3 extends StatefulWidget {
  const Step3({super.key});

  @override
  Step3State createState() => Step3State();
}

class Step3State extends State<Step3> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // COntenedor de paginas
        Image.asset(
          'assets/images/onboarding/onboarding3.jpg',
          height: SizeConfig.scaleHeight(40),
        ),
        SizedBox(height: SizeConfig.scaleHeight(3)),
        CustomText(
            text:
                'Reserva tu primera clase y comienza tu viaje hacia una vida más saludable y equilibrada',
            fontSize: SizeConfig.scaleText(2.5),
            fontWeight: FontWeight.w400),
      ],
    );
  }
}
