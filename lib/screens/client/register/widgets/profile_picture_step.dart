import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/providers/register/register_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/widgets/custom_text_button.dart';
import 'package:provider/provider.dart';

class ProfilePictureStep extends StatelessWidget {
  const ProfilePictureStep({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(builder: (context, registerProvider, child) {
      return SizedBox(
        height: SizeConfig.scaleHeight(35),
        child: Column(
          children: [
            CircleAvatar(
              radius: SizeConfig.scaleImage(25),
              backgroundColor: AppColors.grey300,
              child: registerProvider.profilePhotoUrl.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.file(
                        width: SizeConfig.scaleImage(45),
                        height: SizeConfig.scaleImage(45),
                        File(registerProvider.profilePhotoUrl),
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(
                      FontAwesomeIcons.cameraRetro,
                      size: SizeConfig.scaleHeight(10),
                      color: AppColors.white100,
                    ),
            ),
            CustomTextButton(
              text: 'Subir una foto',
              onPressed: (){

              },
              color: AppColors.grey300,
            ),
          ],
        ),
      );
    });
  }
}
