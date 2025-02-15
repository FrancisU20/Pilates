import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pilates/providers/register/register_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/theme/widgets/custom_text_field.dart';
import 'package:pilates/config/size_config.dart';
import 'package:provider/provider.dart';

class Step1 extends StatefulWidget {
  const Step1({
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
  Step1State createState() => Step1State();
}

class Step1State extends State<Step1> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RegisterProvider registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
              text: 'Ingresa tus datos por favor:',
              fontWeight: FontWeight.w400,
              fontSize:SizeConfig.scaleText(2)),
          SizedBox(height: SizeConfig.scaleHeight(2)),
          SizedBox(
                height: SizeConfig.scaleHeight(1),
              ),
              CustomTextField(
            title: 'Correo electrónico',
            labelColor: AppColors.black100,
            hintText: 'info@example.com',
            typeTextField: TextFieldType.email,
            controller: widget.emailController,
            fontSize:SizeConfig.scaleText(1.7),
            onChanged: (value) {
              registerProvider.setEmail(value);
            },
          ),
          SizedBox(
                height: SizeConfig.scaleHeight(1),
              ),
              CustomTextField(
            title: 'Cédula de identidad',
            labelColor: AppColors.black100,
            hintText: '1003368724',
            typeTextField: TextFieldType.dni,
            controller: widget.dniController,
            fontSize:SizeConfig.scaleText(1.7),
            onChanged: (value) {
              registerProvider.setDni(value);
            },
          ),
          Row(
            children: [
              Expanded(
                child: 
              CustomTextField(
                  title: 'Nombre',
                  labelColor: AppColors.black100,
                  hintText: 'Escribe tu nombre aquí',
                  typeTextField: TextFieldType.alphanumeric,
                  width: 38.5,
                  controller: widget.nameController,
                  fontSize:SizeConfig.scaleText(1.7),
                  onChanged: (value) {
                    registerProvider.setName(value);
                  },
                ),
              ),
              SizedBox(width: SizeConfig.scaleWidth(2)),
              Expanded(
                child: 
              CustomTextField(
                  title: 'Apellido',
                  labelColor: AppColors.black100,
                  hintText: 'Escribe tu apellido aquí',
                  typeTextField: TextFieldType.alphanumeric,
                  width: 38.5,
                  controller: widget.lastNameController,
                  fontSize:SizeConfig.scaleText(1.7),
                  onChanged: (value) {
                    registerProvider.setLastname(value);
                  },
                ),
              ),
            ],
          ),
          SizedBox(
                height: SizeConfig.scaleHeight(1),
              ),
              CustomTextField(
            title: 'Contraseña',
            labelColor: AppColors.black100,
            hintText: '**********',
            typeTextField: TextFieldType.password,
            controller: widget.passwordController,
            fontSize:SizeConfig.scaleText(1.7),
            onChanged: (value) {
              registerProvider.setPassword(value);
            },
          ),
          SizedBox(
                height: SizeConfig.scaleHeight(1),
              ),
              CustomTextField(
            title: 'Repite tu Contraseña',
            labelColor: AppColors.black100,
            hintText: '**********',
            typeTextField: TextFieldType.repeatPassword,
            controller: widget.repeatPasswordController,
            fontSize:SizeConfig.scaleText(1.7),
            compareValue: registerProvider.password,
            onChanged: (value) {
              registerProvider.setRepeatPassword(value);
            },
          ),
          Row(
            children: [
              Expanded(
                child: 
              CustomTextField(
                  title: 'Cumpleaños',
                  labelColor: AppColors.black100,
                  hintText: '01/01/2000',
                  typeTextField: TextFieldType.date,
                  width: 38.5,
                  controller: widget.birthdayController,
                  fontSize:SizeConfig.scaleText(1.7),
                  onChanged: (value) {
                    registerProvider.setBirthday(DateTime.parse(value));
                  },
                ),
              ),
              SizedBox(width: SizeConfig.scaleWidth(2)),
              Expanded(
                child: 
              CustomTextField(
                  title: 'Teléfono',
                  labelColor: AppColors.black100,
                  hintText: '0987654321',
                  typeTextField: TextFieldType.phone,
                  width: 38.5,
                  controller: widget.phoneController,
                  fontSize:SizeConfig.scaleText(1.7),
                  onChanged: (value) {
                    registerProvider.setPhone(value);
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.scaleHeight(1)),
        ],
      ),
    );
  }
}
