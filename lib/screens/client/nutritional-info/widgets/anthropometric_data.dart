import 'package:flutter/material.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/providers/nutritional-info/nutritional_info_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/theme/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class AnthropometricData extends StatefulWidget {
  const AnthropometricData({
    super.key,
    required this.weightController,
    required this.heightController,
    required this.neckCircumferenceController,
    required this.waistCircumferenceController,
    required this.hipCircumferenceController,
  });

  final TextEditingController weightController;
  final TextEditingController heightController;
  final TextEditingController neckCircumferenceController;
  final TextEditingController waistCircumferenceController;
  final TextEditingController hipCircumferenceController;

  @override
  AnthropometricDataState createState() => AnthropometricDataState();
}

class AnthropometricDataState extends State<AnthropometricData> {
  @override
  void initState() {
    super.initState();
    //? Calcular edad
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
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
                  text: 'Medidas Antropométricas',
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
                title: 'Peso (lb)',
                labelColor: AppColors.black100,
                hintText: '110 lb',
                typeTextField: TextFieldType.number,
                controller: widget.weightController,
                fontSize: SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  nutritionalInfoProvider.setDiabetes(value);
                },
              ),
              CustomTextField(
                title: 'Estatura (cm)',
                labelColor: AppColors.black100,
                hintText: '170 cm',
                typeTextField: TextFieldType.number,
                controller: widget.heightController,
                fontSize: SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  nutritionalInfoProvider.setDiabetes(value);
                },
              ),
              CustomTextField(
                title: 'Circunferencia de Cuello (cm)',
                labelColor: AppColors.black100,
                hintText: '40 cm',
                typeTextField: TextFieldType.number,
                controller: widget.neckCircumferenceController,
                fontSize: SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  nutritionalInfoProvider.setDiabetes(value);
                },
              ),
              CustomTextField(
                title: 'Circunferencia de Cintura (cm)',
                labelColor: AppColors.black100,
                hintText: '80 cm',
                typeTextField: TextFieldType.number,
                controller: widget.waistCircumferenceController,
                fontSize: SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  nutritionalInfoProvider.setDiabetes(value);
                },
              ),
              CustomTextField(
                title: 'Circunferencia de Cadera (cm)',
                labelColor: AppColors.black100,
                hintText: '90 cm',
                typeTextField: TextFieldType.number,
                controller: widget.hipCircumferenceController,
                fontSize: SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  nutritionalInfoProvider.setDiabetes(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
