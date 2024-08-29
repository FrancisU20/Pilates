import 'package:flutter/material.dart';
import 'package:pilates/theme/widgets/buttons.dart';
import 'package:pilates/theme/widgets/images_containers.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';

class Step1 extends StatefulWidget {
  const Step1({super.key});

  @override
  Step1State createState() => Step1State();
}

class Step1State extends State<Step1> {
  Buttons buttons = Buttons();
  Texts texts = Texts();
  ImagesContainers imagesContainers = ImagesContainers();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // COntenedor de paginas
        imagesContainers.largeImage(
          'assets/images/onboarding/onboarding1.jpg',
        ),
        SizedBox(height: 3 * SizeConfig.heightMultiplier),
        texts.normalText(
            text:
                'Experimenta los beneficios de nuestros servicios y siente la diferencia desde la primera sesión.',
            fontSize: 2.5 * SizeConfig.textMultiplier,
            fontWeight: FontWeight.w400),
      ],
    );
  }
}
