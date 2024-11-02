import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/widgets/buttons.dart';
import 'package:pilates/utils/size_config.dart';

class ProfilePictureStep extends StatelessWidget {
  const ProfilePictureStep({
    super.key,
    required this.imageFile,
    required this.onShowPicker,
    required this.buttons,
  });

  final XFile? imageFile;
  final VoidCallback onShowPicker;
  final Buttons buttons;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35 * SizeConfig.heightMultiplier,
      child: Column(
        children: [
          CircleAvatar(
            radius: 25 * SizeConfig.imageSizeMultiplier,
            backgroundColor: ColorsPalette.greyAged,
            child: imageFile != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.file(
                      width: 45 * SizeConfig.imageSizeMultiplier,
                      height: 45 * SizeConfig.imageSizeMultiplier,
                      File(imageFile!.path),
                      fit: BoxFit.cover,
                    ),
                  )
                : Icon(
                    FontAwesomeIcons.cameraRetro,
                    size: 10 * SizeConfig.heightMultiplier,
                    color: ColorsPalette.white,
                  ),
          ),
          buttons.underlineText(
            text: 'Subir una foto',
            onPressed: onShowPicker,
            color: ColorsPalette.greyChocolate,
          ),
        ],
      ),
    );
  }
}
