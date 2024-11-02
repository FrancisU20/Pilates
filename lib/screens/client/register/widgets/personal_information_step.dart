import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/widgets/textfields.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';

class PersonalInformationStep extends StatefulWidget {
  const PersonalInformationStep({
    super.key,
    required this.formKey,
    required this.textFormFields,
    required this.texts,
    required this.emailController,
    required this.passwordController,
    required this.repeatPasswordController,
    required this.nameController,
    required this.lastNameController,
    required this.birthdayController,
    required this.phoneController,
    required this.dniController,
  });

  final GlobalKey<FormState> formKey;
  final TextFormFields textFormFields;
  final Texts texts;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;
  final TextEditingController nameController;
  final TextEditingController lastNameController;
  final TextEditingController birthdayController;
  final TextEditingController phoneController;
  final TextEditingController dniController;

  @override
  PersonalInformationStepState createState() => PersonalInformationStepState();
}

class PersonalInformationStepState extends State<PersonalInformationStep> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.texts.normalText(
              text: 'Ingresa tus datos por favor:',
              fontWeight: FontWeight.w400),
          SizedBox(height: 2 * SizeConfig.heightMultiplier),
          widget.textFormFields.create(
            title: 'Correo electrónico',
            labelcolor: ColorsPalette.black,
            hintText: 'info@example.com',
            typeTextField: TextFieldType.email,
            controller: widget.emailController,
          ),
          SizedBox(height: 1 * SizeConfig.heightMultiplier),
          widget.textFormFields.create(
            title: 'Cédula de identidad',
            labelcolor: ColorsPalette.black,
            hintText: '1003368724',
            typeTextField: TextFieldType.dni,
            controller: widget.dniController,
          ),
          SizedBox(height: 1 * SizeConfig.heightMultiplier),
          Row(
            children: [
              widget.textFormFields.create(
                title: 'Nombre',
                labelcolor: ColorsPalette.black,
                hintText: 'Escribe tu nombre aquí',
                typeTextField: TextFieldType.alphanumeric,
                width: 38.5,
                controller: widget.nameController,
              ),
              SizedBox(width: 1 * SizeConfig.widthMultiplier),
              widget.textFormFields.create(
                title: 'Apellido',
                labelcolor: ColorsPalette.black,
                hintText: 'Escribe tu apellido aquí',
                typeTextField: TextFieldType.alphanumeric,
                width: 38.5,
                controller: widget.lastNameController,
              ),
            ],
          ),
          SizedBox(height: 1 * SizeConfig.heightMultiplier),
          widget.textFormFields.create(
            title: 'Contraseña',
            labelcolor: ColorsPalette.black,
            hintText: '**********',
            typeTextField: TextFieldType.password,
            controller: widget.passwordController,
          ),
          SizedBox(height: 1 * SizeConfig.heightMultiplier),
          widget.textFormFields.create(
            title: 'Repite tu Contraseña',
            labelcolor: ColorsPalette.black,
            hintText: '**********',
            typeTextField: TextFieldType.password,
            controller: widget.repeatPasswordController,
          ),
          SizedBox(height: 1 * SizeConfig.heightMultiplier),
          Row(
            children: [
              widget.textFormFields.create(
                  title: 'Cumpleaños',
                  labelcolor: ColorsPalette.black,
                  hintText: '01/01/2000',
                  typeTextField: TextFieldType.date,
                  width: 38.5,
                  controller: widget.birthdayController),
              SizedBox(width: 1 * SizeConfig.widthMultiplier),
              widget.textFormFields.create(
                title: 'Teléfono',
                labelcolor: ColorsPalette.black,
                hintText: '0987654321',
                typeTextField: TextFieldType.phone,
                width: 38.5,
                controller: widget.phoneController,
              ),
            ],
          ),
          SizedBox(height: 2 * SizeConfig.heightMultiplier),
        ],
      ),
    );
  }
}
