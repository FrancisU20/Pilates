import 'package:flutter/material.dart';
import 'package:pilates/theme/widgets/custom_button.dart';
import 'package:pilates/theme/widgets/images_containers.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';

class Step2 extends StatefulWidget {
  const Step2({super.key});

  @override
  Step2State createState() => Step2State();
}

class Step2State extends State<Step2> {
  Buttons buttons = Buttons();
  Texts texts = Texts();
  ImagesContainers imagesContainers = ImagesContainers();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // COntenedor de paginas
        imagesContainers.largeImage(
          'assets/images/onboarding/onboarding2.jpg',
        ),
        SizedBox(height: 3 * SizeConfig.heightMultiplier),
        texts.normalText(
            text:
                'Descubre cómo nuestras rutinas te ayudarán a aumentar tu flexibilidad y fortaleza',
            fontSize: 2.5 * SizeConfig.textMultiplier,
            fontWeight: FontWeight.w400),
      ],
    );
  }
}
