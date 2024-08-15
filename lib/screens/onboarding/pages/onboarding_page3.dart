import 'package:flutter/material.dart';
import 'package:pilates/theme/widgets/buttons.dart';
import 'package:pilates/theme/widgets/images_containers.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';

class Step3 extends StatefulWidget {
  const Step3({super.key});

  @override
  Step3State createState() => Step3State();
}

class Step3State extends State<Step3> {
  Buttons buttons = Buttons();
  Texts texts = Texts();
  ImagesContainers imagesContainers = ImagesContainers();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // COntenedor de paginas
        imagesContainers.largeImage(
          'https://www.studio9-pilates.nl/wp-content/uploads/2024/03/Studio-9-Website_722x1088_homepage_20242-679x1024.jpg',
        ),
        SizedBox(height: 3 * SizeConfig.heightMultiplier),
        texts.titleText(
            text:
                'Reserva tu primera clase y comienza tu viaje hacia una vida más saludable y equilibrada.'),
      ],
    );
  }
}
