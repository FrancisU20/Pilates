import 'package:flutter/material.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/providers/nutritional-info/nutritional_info_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/theme/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({
    super.key,
    required this.completeNameController,
    required this.birthDateController,
    required this.ageController,
    required this.genderController,
    required this.maritalStatusController,
    required this.addressController,
    required this.occupationController,
    required this.phoneController,
    required this.emailController,
  });

  final TextEditingController completeNameController;
  final TextEditingController birthDateController;
  final TextEditingController ageController;
  final TextEditingController genderController;
  final TextEditingController maritalStatusController;
  final TextEditingController addressController;
  final TextEditingController occupationController;
  final TextEditingController phoneController;
  final TextEditingController emailController;

  @override
  PersonalInformationState createState() => PersonalInformationState();
}

class PersonalInformationState extends State<PersonalInformation> {
  @override
  void initState() {
    super.initState();
    //? Calcular edad
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      NutritionalInfoProvider nutritionalInfoProvider =
          Provider.of<NutritionalInfoProvider>(context, listen: false);
      await nutritionalInfoProvider.getExistingPersonalInformation(context);
      //? el await es para esperar a que se ejecute el método getExistingData
      widget.completeNameController.text = nutritionalInfoProvider.completeName;
      widget.birthDateController.text =
          nutritionalInfoProvider.birthDate.toString().substring(0, 10);
      widget.ageController.text = nutritionalInfoProvider.age.toString();
      widget.genderController.text =
          nutritionalInfoProvider.gender.toString() == 'M'
              ? 'Masculino'
              : nutritionalInfoProvider.gender.toString() == 'F'
                  ? 'Femenino'
                  : 'LGBTQ+';
      widget.phoneController.text = nutritionalInfoProvider.phone.toString();
      widget.emailController.text = nutritionalInfoProvider.email.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    NutritionalInfoProvider nutritionalInfoProvider =
        Provider.of<NutritionalInfoProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.scaleWidth(5),
        vertical: SizeConfig.scaleHeight(2),
      ),
      decoration: BoxDecoration(
        color: AppColors.white200,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.black100.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Form(
        child: Column(
          children: [
            Center(
              child: CustomText(
                  text: 'Datos de Identificación',
                  color: AppColors.black100,
                  fontSize: SizeConfig.scaleText(2.5),
                  fontWeight: FontWeight.w500,
                  maxLines: 2,),
            ),
            SizedBox(
              height: SizeConfig.scaleHeight(1),
            ),
            CustomTextField(
              title: 'Nombre',
              labelColor: AppColors.black100,
              hintText: '',
              typeTextField: TextFieldType.alphanumeric,
              controller: widget.completeNameController,
              fontSize: SizeConfig.scaleText(1.7),
              isActive: false,
            ),
            CustomTextField(
              title: 'Fecha de nacimiento',
              labelColor: AppColors.black100,
              hintText: '',
              typeTextField: TextFieldType.alphanumeric,
              controller: widget.birthDateController,
              fontSize: SizeConfig.scaleText(1.7),
              isActive: false,
            ),
            CustomTextField(
              title: 'Edad',
              labelColor: AppColors.black100,
              hintText: '',
              typeTextField: TextFieldType.number,
              controller: widget.ageController,
              fontSize: SizeConfig.scaleText(1.7),
              isActive: false,
            ),
            CustomTextField(
              title: 'Sexo',
              labelColor: AppColors.black100,
              hintText: '',
              typeTextField: TextFieldType.alphanumeric,
              controller: widget.genderController,
              fontSize: SizeConfig.scaleText(1.7),
              isActive: false,
            ),
            CustomTextField(
              title: 'Estado civil',
              labelColor: AppColors.black100,
              hintText: 'Casado/a, Soltero/a etc.',
              typeTextField: TextFieldType.alphanumeric,
              controller: widget.maritalStatusController,
              fontSize: SizeConfig.scaleText(1.7),
              onChanged: (value) {
                nutritionalInfoProvider.setEmail(value);
              },
            ),
            CustomTextField(
              title: 'Dirección',
              labelColor: AppColors.black100,
              hintText: 'Calle 123',
              typeTextField: TextFieldType.alphanumeric,
              controller: widget.addressController,
              fontSize: SizeConfig.scaleText(1.7),
              onChanged: (value) {
                nutritionalInfoProvider.setEmail(value);
              },
            ),
            CustomTextField(
              title: 'Ocupación',
              labelColor: AppColors.black100,
              hintText: 'Estudiante, Ingeniero, etc.',
              typeTextField: TextFieldType.alphanumeric,
              controller: widget.occupationController,
              fontSize: SizeConfig.scaleText(1.7),
              onChanged: (value) {
                nutritionalInfoProvider.setEmail(value);
              },
            ),
            CustomTextField(
              title: 'Teléfono',
              labelColor: AppColors.black100,
              hintText: '0987654321',
              typeTextField: TextFieldType.phone,
              controller: widget.phoneController,
              fontSize: SizeConfig.scaleText(1.7),
              isActive: false,
            ),
            CustomTextField(
              title: 'Correo electrónico',
              labelColor: AppColors.black100,
              hintText: 'info@example.com',
              typeTextField: TextFieldType.email,
              controller: widget.emailController,
              fontSize: SizeConfig.scaleText(1.7),
              isActive: false,
            ),
          ],
        ),
      ),
    );
  }
}
