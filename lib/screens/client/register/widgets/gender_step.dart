import 'package:flutter/material.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';

class GenderStep extends StatefulWidget {
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
  GenderStepState createState() => GenderStepState();
}

class GenderStepState extends State<GenderStep> {
  late String _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.gender;
  }

  void _updateGender(String gender) {
    setState(() {
      _selectedGender = gender;
    });
    widget.onGenderChanged(gender);
  }

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
                _updateGender('Male');
              },
              child: Container(
                padding: EdgeInsets.all(2 * SizeConfig.widthMultiplier),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _selectedGender == 'Male'
                        ? ColorsPalette.beigeAged
                        : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: ColorsPalette.white,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/male.jpg',
                      width: 15 * SizeConfig.heightMultiplier,
                      fit: BoxFit.contain,
                    ),
                    widget.texts.normalText(
                      text: 'Hombre',
                      color: _selectedGender == 'Male'
                          ? ColorsPalette.beigeAged
                          : ColorsPalette.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _updateGender('Female');
              },
              child: Container(
                padding: EdgeInsets.all(2 * SizeConfig.widthMultiplier),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _selectedGender == 'Female'
                        ? ColorsPalette.beigeAged
                        : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: ColorsPalette.white,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/female.jpg',
                      width: 15 * SizeConfig.heightMultiplier,
                      fit: BoxFit.contain,
                    ),
                    widget.texts.normalText(
                        text: 'Mujer',
                        color: _selectedGender == 'Female'
                            ? ColorsPalette.beigeAged
                            : ColorsPalette.black,
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
              _updateGender('Others');
            },
            child: SizedBox(
              height: 5 * SizeConfig.heightMultiplier,
              width: 50 * SizeConfig.widthMultiplier,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _selectedGender == 'Others'
                        ? ColorsPalette.beigeAged
                        : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: ColorsPalette.white,
                ),
                child: Center(
                  child: widget.texts.normalText(
                      text: 'Prefiero no contestar',
                      color: _selectedGender == 'Others'
                          ? ColorsPalette.beigeAged
                          : ColorsPalette.black,
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
