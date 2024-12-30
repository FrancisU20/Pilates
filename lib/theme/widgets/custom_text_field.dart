import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/components/app_birthday_picker.dart';

enum TextFieldType { phone, email, number, alphanumeric, date, password, dni }

class CustomTextField extends StatefulWidget {
  final String title;
  final String hintText;
  final Color labelColor;
  final TextFieldType typeTextField;
  final TextEditingController controller;
  final IconData? icon;
  final String? initialValue;
  final Color? fillColor;
  final bool isActive;
  final double width;
  final double height;

  const CustomTextField({
    super.key,
    required this.title,
    required this.hintText,
    required this.labelColor,
    required this.typeTextField,
    required this.controller,
    this.icon,
    this.initialValue,
    this.fillColor = AppColors.white100,
    this.isActive = true,
    this.width = 90,
    this.height = 8,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late List<TextInputFormatter> inputFormatters;
  late TextInputType keyboardType;
  bool obscureText = false;

  @override
  void initState() {
    super.initState();

    // Configurar inputFormatters y keyboardType basado en el tipo
    switch (widget.typeTextField) {
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
    if (widget.initialValue != null) {
      widget.controller.text = widget.initialValue!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.scaleWidth(widget.width),
      height: SizeConfig.scaleHeight(widget.height),
      child: GestureDetector(
        onTap: widget.typeTextField == TextFieldType.date
            ? () => AppBirthdayPicker.selectBirthday(context, widget.controller)
            : null,
        child: AbsorbPointer(
          absorbing: widget.typeTextField == TextFieldType.date,
          child: TextFormField(
            controller: widget.controller,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              labelText: widget.title,
              labelStyle: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: widget.labelColor,
                  fontSize: SizeConfig.scaleText(2),
                  fontWeight: FontWeight.w400,
                ),
              ),
              alignLabelWithHint: true,
              hintText: widget.hintText,
              hintStyle: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: AppColors.grey300,
                  fontSize: SizeConfig.scaleText(2),
                  fontWeight: FontWeight.w400,
                ),
              ),
              filled: true,
              fillColor: widget.fillColor,
              prefixIcon: widget.icon != null
                  ? Icon(
                      widget.icon,
                      color: AppColors.grey300,
                      size: SizeConfig.scaleHeight(2),
                    )
                  : null,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.grey300,
                  width: SizeConfig.scaleWidth(0.2),
                ),
              ),
              suffixIcon: widget.typeTextField == TextFieldType.password
                  ? IconButton(
                      icon: Icon(
                        obscureText
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        color: AppColors.grey300,
                        size: SizeConfig.scaleHeight(2),
                      ),
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    )
                  : null,
            ),
            enabled: widget.isActive,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                color: AppColors.black100,
                fontSize: SizeConfig.scaleText(2),
                fontWeight: FontWeight.w400,
              ),
            ),
            cursorColor: AppColors.grey300,
            cursorWidth: SizeConfig.scaleWidth(0.2),
          ),
        ),
      ),
    );
  }
}
