import 'package:flutter/material.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';

class GenderStep extends StatelessWidget {
  const GenderStep({
    super.key,
    required this.gender,
    required this.texts,
    required this.onGenderChanged,
  });

  final String gender;
  final Texts texts;
  final ValueChanged<String> onGenderChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                onGenderChanged('Male');
              },
              child: Container(
                padding: EdgeInsets.all(2 * SizeConfig.widthMultiplier),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: gender == 'Male'
                        ? ColorsPalette.primaryColor
                        : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Image.network(
                      'https://img.freepik.com/free-photo/handsome-muscular-guy-with-naked-torso_144627-806.jpg?w=740&t=st=1719243581~exp=1719244181~hmac=0d216dee2003a8b4dcb4cea87768f85ff4c438f053c21ebf724d41ce7315b050',
                      width: 15 * SizeConfig.heightMultiplier,
                      fit: BoxFit.contain,
                    ),
                    texts.normalText(
                      text: 'Hombre',
                      color: gender == 'Male'
                          ? ColorsPalette.primaryColor
                          : Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                onGenderChanged('Female');
              },
              child: Container(
                padding: EdgeInsets.all(2 * SizeConfig.widthMultiplier),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: gender == 'Female'
                          ? ColorsPalette.primaryColor
                          : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  children: [
                    Image.network(
                      'https://img.freepik.com/free-photo/lady-demonstrate-exercises-strong-body-figure-isolated_231208-3416.jpg?t=st=1719244130~exp=1719247730~hmac=6a9bf2ff65bb0572743f704a6f59e849ec2374ac536faecf0ed25ae0055a6d03&w=740',
                      width: 15 * SizeConfig.heightMultiplier,
                      fit: BoxFit.contain,
                    ),
                    texts.normalText(
                        text: 'Mujer',
                        color: gender == 'Female'
                            ? ColorsPalette.primaryColor
                            : Colors.black,
                        fontWeight: FontWeight.w400),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 2 * SizeConfig.heightMultiplier),
        Center(
          child: GestureDetector(
            onTap: () {
              onGenderChanged('Others');
            },
            child: SizedBox(
              height: 5 * SizeConfig.heightMultiplier,
              width: 50 * SizeConfig.widthMultiplier,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: gender == 'Others'
                        ? ColorsPalette.primaryColor
                        : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Center(
                  child: texts.normalText(
                      text: 'Prefiero no contestar',
                      color: gender == 'Others'
                          ? ColorsPalette.primaryColor
                          : Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 1.5 * SizeConfig.heightMultiplier),
      ],
    );
  }
}
