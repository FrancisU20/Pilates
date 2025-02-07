import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/components/common/app_birthday_picker.dart';
import 'package:pilates/theme/components/common/app_dialogs.dart';

enum TextFieldType {
  phone,
  email,
  number,
  numberInt,
  alphanumeric,
  date,
  password,
  repeatPassword,
  dni,
  boolean,
  diseases
}

class CustomTextField extends StatefulWidget {
  final String title;
  final String hintText;
  final Color labelColor;
  final TextFieldType typeTextField;
  final TextEditingController controller;
  final IconData? icon;
  final String? initialValue;
  final Color? fillColor;
  final double? fontSize;
  final bool isActive;
  final double width;
  final double height;
  final void Function(String)? onChanged;
  final String? compareValue;
  final bool? disableError;

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
    this.fontSize = 1.7,
    this.isActive = true,
    this.width = 90,
    this.height = 8,
    this.onChanged,
    this.compareValue,
    this.disableError = false,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late TextInputType keyboardType;
  late Color textColor;
  List<TextInputFormatter> inputFormatters = [];
  bool obscureText = false;

  @override
  void initState() {
    super.initState();

    textColor = widget.labelColor;
    obscureText = false;

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
        inputFormatters = [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*[\.,]?\d*')),
          TextInputFormatter.withFunction((oldValue, newValue) {
            return TextEditingValue(
              text: newValue.text.replaceAll(',', '.'),
              selection: newValue.selection,
            );
          }),
        ];
        keyboardType = const TextInputType.numberWithOptions(decimal: true);
        break;
      case TextFieldType.numberInt:
        inputFormatters = [FilteringTextInputFormatter.digitsOnly];
        keyboardType = TextInputType.number;
        break;
      case TextFieldType.password:
        obscureText = true;
        keyboardType = TextInputType.visiblePassword;
        break;
      case TextFieldType.repeatPassword:
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
      case TextFieldType.boolean:
        keyboardType = TextInputType.text;
        break;
      case TextFieldType.diseases:
        keyboardType = TextInputType.text;
        break;
      default:
        keyboardType = TextInputType.text;
    }

    // Set initial value if provided
    if (widget.initialValue != null) {
      widget.controller.text = widget.initialValue!;
    }
  }

  bool validateInput(String value) {
    switch (widget.typeTextField) {
      case TextFieldType.phone:
        return value.length == 10;
      case TextFieldType.email:
        return value.contains('@') && value.contains('.');
      case TextFieldType.number:
        return value.isNotEmpty;
      case TextFieldType.numberInt:
        return value.isNotEmpty;
      case TextFieldType.alphanumeric:
        return value.isNotEmpty;
      case TextFieldType.date:
        return value.isNotEmpty;
      case TextFieldType.password:
        return RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,15}$')
            .hasMatch(value);
      case TextFieldType.repeatPassword:
        return value == widget.compareValue;
      case TextFieldType.dni:
        return value.length == 10;
      case TextFieldType.boolean:
        return value.isNotEmpty;
      case TextFieldType.diseases:
        return value.isNotEmpty;
      default:
        return value.isNotEmpty;
    }
  }

  String getValidationError() {
    switch (widget.typeTextField) {
      case TextFieldType.phone:
        return '* Teléfono requerido';
      case TextFieldType.email:
        return '* Email requerido';
      case TextFieldType.number:
        return '* Requerido';
      case TextFieldType.numberInt:
        return '* Requerido';
      case TextFieldType.alphanumeric:
        return '* Requerido';
      case TextFieldType.date:
        return '* Requerido';
      case TextFieldType.password:
        return '* Al menos una mayúscula, un número y un caracter especial';
      case TextFieldType.repeatPassword:
        return '* Las contraseñas no coinciden';
      case TextFieldType.dni:
        return '* Cédula requerida';
      case TextFieldType.boolean:
        return '* Requerido';
      case TextFieldType.diseases:
        return '* Requerido';
      default:
        return '* Requerido';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.typeTextField == TextFieldType.date && widget.isActive
          ? () async {
              await AppBirthdayPicker.selectBirthday(
                  context, widget.controller);
              if (widget.onChanged != null) {
                widget.onChanged!(
                    widget.controller.text); // Llamar a onChanged manualmente
              }
            }
          : widget.typeTextField == TextFieldType.boolean && widget.isActive
              ? () async {
                  await AppDialogs.showBooleanOptions(
                      context, widget.controller, widget.title);
                  if (widget.onChanged != null) {
                    widget.onChanged!(widget
                        .controller.text); // Llamar a onChanged manualmente
                  }
                }
              : widget.typeTextField == TextFieldType.diseases &&
                      widget.isActive
                  ? () async {
                      await AppDialogs.showDiseasesOptions(
                          context, widget.controller, widget.title);
                      if (widget.onChanged != null) {
                        widget.onChanged!(widget
                            .controller.text); // Llamar a onChanged manualmente
                      }
                    }
                  : null,
      child: AbsorbPointer(
        absorbing: (widget.typeTextField == TextFieldType.date ||
                widget.typeTextField == TextFieldType.boolean ||
                widget.typeTextField == TextFieldType.diseases)
            ? true
            : false,
        child: TextFormField(
          controller: widget.controller,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
              labelText: widget.title,
              labelStyle: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: textColor,
                  fontSize: widget.fontSize!,
                  fontWeight: FontWeight.w400,
                ),
              ),
              alignLabelWithHint: true,
              hintText: widget.hintText,
              hintStyle: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: textColor,
                  fontSize: widget.fontSize!,
                  fontWeight: FontWeight.w400,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: SizeConfig.scaleHeight(1),
                horizontal: SizeConfig.scaleWidth(2),
              ),
              filled: true,
              fillColor: widget.isActive
                  ? widget.fillColor
                  : widget.fillColor?.withOpacity(0.5),
              prefixIcon: widget.icon != null
                  ? Icon(
                      widget.icon,
                      color: textColor,
                      size: SizeConfig.scaleHeight(2),
                    )
                  : null,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: textColor,
                  width: SizeConfig.scaleWidth(0.2),
                ),
              ),
              suffixIcon: widget.typeTextField == TextFieldType.password ||
                      widget.typeTextField == TextFieldType.repeatPassword
                  ? IconButton(
                      icon: Icon(
                        obscureText
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        color: textColor,
                        size: SizeConfig.scaleHeight(2),
                      ),
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    )
                  : widget.typeTextField == TextFieldType.date
                      ? IconButton(
                          icon: Icon(
                            FontAwesomeIcons.calendar,
                            color: textColor,
                            size: SizeConfig.scaleHeight(2),
                          ),
                          onPressed: () {
                            AppBirthdayPicker.selectBirthday(
                                context, widget.controller);
                          },
                        )
                      : null,
              errorText: validateInput(widget.controller.text)
                  ? null
                  : widget.disableError == true
                      ? null
                      : getValidationError(),
              errorStyle: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: AppColors.red300,
                  fontSize: widget.fontSize! - 3,
                  fontWeight: FontWeight.w400,
                ),
              ),
              errorMaxLines: 2),
          enabled: widget.isActive,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              color: textColor,
              fontSize: widget.fontSize!,
              fontWeight: FontWeight.w400,
            ),
          ),
          cursorColor: textColor,
          cursorWidth: SizeConfig.scaleWidth(0.2),
          onChanged: (value) {
            bool validateText = validateInput(widget.controller.text);
            if (validateText == false && widget.disableError == false) {
              setState(() {
                textColor = AppColors.red300;
              });
            } else {
              setState(() {
                textColor = widget.labelColor;
              });
            }

            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
        ),
      ),
    );
  }
}
