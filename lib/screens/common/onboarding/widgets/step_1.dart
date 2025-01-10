import 'package:flutter/material.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_image_network.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';

class Step1 extends StatefulWidget {
  const Step1({super.key});

  @override
  Step1State createState() => Step1State();
}

class Step1State extends State<Step1> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomImageNetwork(
          imagePath: 'https://curvepilates-bucket.s3.amazonaws.com/app-assets/onboarding/onboarding1.jpg',
          height: SizeConfig.scaleHeight(50),
          borderRadius: 15.0,
          errorBackgroundColor: AppColors.white200,
          errorIconColor: AppColors.red300,
          errorIconSize: SizeConfig.scaleHeight(20),
        ),
        SizedBox(height: SizeConfig.scaleHeight(3)),
        CustomText(
            text:
                'Experimenta los beneficios de nuestros servicios y siente la diferencia',
            fontSize:SizeConfig.scaleText(2.5),
            fontWeight: FontWeight.w400,
            maxLines: 3,),
      ],
    );
  }
}
