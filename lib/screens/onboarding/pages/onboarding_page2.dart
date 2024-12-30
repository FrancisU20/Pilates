import 'package:flutter/material.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';

class Step2 extends StatefulWidget {
  const Step2({super.key});

  @override
  Step2State createState() => Step2State();
}

class Step2State extends State<Step2> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // COntenedor de paginas
        Image.asset(
          'assets/images/onboarding/onboarding2.jpg',
          height: SizeConfig.scaleHeight(40),
        ),
        SizedBox(height: SizeConfig.scaleHeight(3)),
        CustomText(
            text:
                'Descubre cómo nuestras rutinas te ayudarán a aumentar tu flexibilidad y fortaleza',
            fontSize: SizeConfig.scaleText(2.5),
            fontWeight: FontWeight.w400),
      ],
    );
  }
}
