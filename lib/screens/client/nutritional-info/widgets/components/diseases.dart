import 'package:flutter/material.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/providers/nutritional-info/nutritional_info_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/theme/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class Diseases extends StatefulWidget {
  const Diseases({
    super.key,
    required this.diabetesController,
    required this.dyslipidemiasController,
    required this.obesityController,
    required this.hypertensionController,
    required this.cancerController,
    required this.hypoHyperthyroidismController,
    required this.otherConditionsController,

    //! agregar viewMode
    this.viewMode = false,
  });

  final TextEditingController diabetesController;
  final TextEditingController dyslipidemiasController;
  final TextEditingController obesityController;
  final TextEditingController hypertensionController;
  final TextEditingController cancerController;
  final TextEditingController hypoHyperthyroidismController;
  final TextEditingController otherConditionsController;

  // ! agregar viewMode
  final bool? viewMode;

  @override
  DiseasesState createState() => DiseasesState();
}

class DiseasesState extends State<Diseases> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NutritionalInfoProvider nutritionalInfoProvider =
        Provider.of<NutritionalInfoProvider>(context, listen: false);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const ClampingScrollPhysics(),
      child: Container(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomText(
                  text: 'Antecedentes Heredo Familiares',
                  color: AppColors.black100,
                  fontSize: SizeConfig.scaleText(2.5),
                  fontWeight: FontWeight.w500,
                  maxLines: 2,
                ),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(1),
              ),
              CustomTextField(
                title: 'Diabetes',
                labelColor: AppColors.black100,
                hintText: '',
                typeTextField: TextFieldType.diseases,
                controller: widget.diabetesController,
                fontSize: SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  nutritionalInfoProvider.setDiabetes(value);
                },
                isActive: widget.viewMode == true ? false : true,
              ),
              CustomTextField(
                title: 'Dislipidemias',
                labelColor: AppColors.black100,
                hintText: '',
                typeTextField: TextFieldType.diseases,
                controller: widget.dyslipidemiasController,
                fontSize: SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  nutritionalInfoProvider.setDyslipidemias(value);
                },
                isActive: widget.viewMode == true ? false : true,
              ),
              CustomTextField(
                title: 'Obesidad',
                labelColor: AppColors.black100,
                hintText: '',
                typeTextField: TextFieldType.diseases,
                controller: widget.obesityController,
                fontSize: SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  nutritionalInfoProvider.setObesity(value);
                },
                isActive: widget.viewMode == true ? false : true,
              ),
              CustomTextField(
                title: 'Hipertensión',
                labelColor: AppColors.black100,
                hintText: '',
                typeTextField: TextFieldType.diseases,
                controller: widget.hypertensionController,
                fontSize: SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  nutritionalInfoProvider.setHypertension(value);
                },
                isActive: widget.viewMode == true ? false : true,
              ),
              CustomTextField(
                title: 'Cáncer',
                labelColor: AppColors.black100,
                hintText: '',
                typeTextField: TextFieldType.diseases,
                controller: widget.cancerController,
                fontSize: SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  nutritionalInfoProvider.setCancer(value);
                },
                isActive: widget.viewMode == true ? false : true,
              ),
              CustomTextField(
                title: 'Hipotiroidismo/Hipertiroidismo',
                labelColor: AppColors.black100,
                hintText: '',
                typeTextField: TextFieldType.diseases,
                controller: widget.hypoHyperthyroidismController,
                fontSize: SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  nutritionalInfoProvider.setHypoHyperthyroidism(value);
                },
                isActive: widget.viewMode == true ? false : true,
              ),
              CustomTextField(
                title: 'Otras condiciones',
                labelColor: AppColors.black100,
                hintText: 'Trastornos alimenticios, etc.',
                typeTextField: TextFieldType.alphanumeric,
                controller: widget.otherConditionsController,
                fontSize: SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  nutritionalInfoProvider.setOtherConditions(value);
                },
                isActive: widget.viewMode == true ? false : true,
                disableError: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
