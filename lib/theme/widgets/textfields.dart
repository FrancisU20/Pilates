import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/screens/register/widgets/birthday_picker.dart';
import 'package:pilates/utils/size_config.dart';

enum TextFieldType { phone, email, number, alphanumeric, date, password, dni }

class TextFormFields {
  Widget create({
    required String title,
    required String hintText,
    required Color labelcolor,
    required TextFieldType typeTextField,
    required TextEditingController controller,
    IconData? icon,
    String? initialValue,
    Color? fillColor = const Color.fromARGB(255, 255, 255, 255),
    bool? isActive = true,
    double width = 90,
    double height = 7,
  }) {
    List<TextInputFormatter> inputFormatters = [];
    TextInputType keyboardType;
    bool obscureText = false;

    switch (typeTextField) {
      case TextFieldType.phone:
        inputFormatters = [LengthLimitingTextInputFormatter(10)];
        keyboardType = TextInputType.phone;
        break;
      case TextFieldType.date:
        inputFormatters = [LengthLimitingTextInputFormatter(10)];
        keyboardType = TextInputType.datetime;
        break;
      case TextFieldType.email:
        keyboardType = TextInputType.emailAddress;
        break;
      case TextFieldType.number:
        inputFormatters = [FilteringTextInputFormatter.digitsOnly];
        keyboardType = TextInputType.number;
        break;
      case TextFieldType.password:
        obscureText = true;
        keyboardType = TextInputType.visiblePassword;
        break;
      case TextFieldType.alphanumeric:
        keyboardType = TextInputType.name;
        break;
      case TextFieldType.dni:
        inputFormatters = [LengthLimitingTextInputFormatter(10)];
        keyboardType = TextInputType.number;
        break;
      default:
        keyboardType = TextInputType.text;
    }

    // Set initial value if provided
    if (initialValue != null) {
      controller.text = initialValue;
    }

    return SizedBox(
      width: width * SizeConfig.widthMultiplier,
      height: height * SizeConfig.heightMultiplier,
      child: StatefulBuilder(
        builder: (context, setState) {
          return GestureDetector(
            onTap: typeTextField == TextFieldType.date
                ? () => BirthdayPicker.selectBirthday(context, controller)
                : null,
            child: AbsorbPointer(
              absorbing: typeTextField == TextFieldType.date,
              child: TextFormField(
                controller: controller,
                inputFormatters: inputFormatters,
                keyboardType: keyboardType,
                obscureText: obscureText,
                decoration: InputDecoration(
                  labelText: title,
                  labelStyle: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      color: ColorsPalette.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  alignLabelWithHint: true,
                  hintText: hintText,
                  hintStyle: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      color: ColorsPalette.grayTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  filled: true,
                  fillColor: fillColor,
                  prefixIcon: icon != null
                      ? Icon(
                          icon,
                          color: ColorsPalette.primaryColor,
                        )
                      : null,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorsPalette.primaryColor,
                      width: 0.2 * SizeConfig.widthMultiplier,
                    ),
                  ),
                  suffixIcon: typeTextField == TextFieldType.password
                      ? IconButton(
                          icon: Icon(
                            obscureText
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            color: ColorsPalette.primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                        )
                      : null,
                ),
                enabled: isActive,
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    color: ColorsPalette.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                cursorColor: ColorsPalette.primaryColor,
                cursorWidth: 0.2 * SizeConfig.widthMultiplier,
              ),
            ),
          );
        },
      ),
    );
  }
}
