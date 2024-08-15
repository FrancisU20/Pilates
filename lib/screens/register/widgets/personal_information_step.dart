import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/widgets/textfields.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';

class PersonalInformationStep extends StatelessWidget {
  PersonalInformationStep({
    super.key,
    required this.formKey,
    required this.textFormFields,
    required this.texts,
  });

  final GlobalKey<FormState> formKey;
  final TextFormFields textFormFields;
  final Texts texts;

  //Controladores de texto
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          texts.normalText(
              text: 'Ingresa tus datos por favor:',
              fontWeight: FontWeight.w400),
          SizedBox(height: 2 * SizeConfig.heightMultiplier),
          textFormFields.create(
            title: 'Correo electrónico',
            labelcolor: ColorsPalette.textColor,
            hintText: 'info@example.com',
            typeTextField: TextFieldType.email,
            controller: emailController,
          ),
          SizedBox(height: 1 * SizeConfig.heightMultiplier),
          Row(
            children: [
              textFormFields.create(
                title: 'Nombre',
                labelcolor: ColorsPalette.textColor,
                hintText: 'Escribe tu nombre aquí',
                typeTextField: TextFieldType.alphanumeric,
                width: 38.5,
                controller: nameController,
              ),
              SizedBox(width: 1 * SizeConfig.widthMultiplier),
              textFormFields.create(
                title: 'Apellido',
                labelcolor: ColorsPalette.textColor,
                hintText: 'Escribe tu apellido aquí',
                typeTextField: TextFieldType.alphanumeric,
                width: 38.5,
                controller: lastNameController,
              ),
            ],
          ),
          SizedBox(height: 1 * SizeConfig.heightMultiplier),
          textFormFields.create(
            title: 'Contraseña',
            labelcolor: ColorsPalette.textColor,
            hintText: '**********',
            typeTextField: TextFieldType.password,
            controller: passwordController,
          ),
          SizedBox(height: 1 * SizeConfig.heightMultiplier),
          textFormFields.create(
            title: 'Repite tu Contraseña',
            labelcolor: ColorsPalette.textColor,
            hintText: '**********',
            typeTextField: TextFieldType.password,
            controller: repeatPasswordController,
          ),
          SizedBox(height: 1 * SizeConfig.heightMultiplier),
          Row(
            children: [
              textFormFields.create(
                  title: 'Cumpleaños',
                  labelcolor: ColorsPalette.textColor,
                  hintText: '01/01/2000',
                  typeTextField: TextFieldType.date,
                  width: 38.5,
                  controller: birthdayController),
              SizedBox(width: 1 * SizeConfig.widthMultiplier),
              textFormFields.create(
                title: 'Teléfono',
                labelcolor: ColorsPalette.textColor,
                hintText: '+593 987 654 321',
                typeTextField: TextFieldType.phone,
                width: 38.5,
                controller: phoneController,
              ),
            ],
          ),
          SizedBox(height: 2 * SizeConfig.heightMultiplier),
        ],
      ),
    );
  }
}
