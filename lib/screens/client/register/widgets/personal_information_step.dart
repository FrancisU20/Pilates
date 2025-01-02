import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/theme/widgets/custom_text_field.dart';
import 'package:pilates/config/size_config.dart';

class PersonalInformationStep extends StatefulWidget {
  const PersonalInformationStep({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.repeatPasswordController,
    required this.nameController,
    required this.lastNameController,
    required this.birthdayController,
    required this.phoneController,
    required this.dniController,
  });

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
              text: 'Ingresa tus datos por favor:',
              fontWeight: FontWeight.w400,
              fontSize: SizeConfig.scaleText(2.5)),
          SizedBox(height: SizeConfig.scaleHeight(2)),
          CustomTextField(
            title: 'Correo electrónico',
            labelColor: AppColors.black100,
            hintText: 'info@example.com',
            typeTextField: TextFieldType.email,
            controller: widget.emailController,
          ),
          SizedBox(height: SizeConfig.scaleHeight(1)),
          CustomTextField(
            title: 'Cédula de identidad',
            labelColor: AppColors.black100,
            hintText: '1003368724',
            typeTextField: TextFieldType.dni,
            controller: widget.dniController,
          ),
          SizedBox(height: SizeConfig.scaleHeight(1)),
          Row(
            children: [
              CustomTextField(
                title: 'Nombre',
                labelColor: AppColors.black100,
                hintText: 'Escribe tu nombre aquí',
                typeTextField: TextFieldType.alphanumeric,
                width: 38.5,
                controller: widget.nameController,
              ),
              SizedBox(width: SizeConfig.scaleWidth(1)),
              CustomTextField(
                title: 'Apellido',
                labelColor: AppColors.black100,
                hintText: 'Escribe tu apellido aquí',
                typeTextField: TextFieldType.alphanumeric,
                width: 38.5,
                controller: widget.lastNameController,
              ),
            ],
          ),
          SizedBox(height: SizeConfig.scaleHeight(1)),
          CustomTextField(
            title: 'Contraseña',
            labelColor: AppColors.black100,
            hintText: '**********',
            typeTextField: TextFieldType.password,
            controller: widget.passwordController,
          ),
          SizedBox(height: SizeConfig.scaleHeight(1)),
          CustomTextField(
            title: 'Repite tu Contraseña',
            labelColor: AppColors.black100,
            hintText: '**********',
            typeTextField: TextFieldType.password,
            controller: widget.repeatPasswordController,
          ),
          SizedBox(height: SizeConfig.scaleHeight(1)),
          Row(
            children: [
              CustomTextField(
                  title: 'Cumpleaños',
                  labelColor: AppColors.black100,
                  hintText: '01/01/2000',
                  typeTextField: TextFieldType.date,
                  width: 38.5,
                  controller: widget.birthdayController),
              SizedBox(width: SizeConfig.scaleWidth(1)),
              CustomTextField(
                title: 'Teléfono',
                labelColor: AppColors.black100,
                hintText: '0987654321',
                typeTextField: TextFieldType.phone,
                width: 38.5,
                controller: widget.phoneController,
              ),
            ],
          ),
          SizedBox(height: SizeConfig.scaleHeight(2)),
        ],
      ),
    );
  }
}
