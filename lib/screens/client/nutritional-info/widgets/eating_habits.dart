import 'package:flutter/material.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/providers/nutritional-info/nutritional_info_provider.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/theme/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class EatingHabits extends StatefulWidget {
  const EatingHabits({
    super.key,
    required this.numberOfMealsController,
    required this.medicationAllergyController,
    required this.takesSupplementController,
    required this.supplementNameController,
    required this.supplementDoseController,
    required this.supplementReasonController,
    required this.foodVariesWithMoodController,
    required this.hasDietPlanController,
    required this.consumesAlcoholController,
    required this.smokesController,
    required this.previousPhysicalActivityController,
    required this.isPregnantController,
    required this.currentPhysicalActivityController,
    required this.currentSportsInjuryDurationController,
  });

  final TextEditingController numberOfMealsController;
  final TextEditingController medicationAllergyController;
  final TextEditingController takesSupplementController;
  final TextEditingController supplementNameController;
  final TextEditingController supplementDoseController;
  final TextEditingController supplementReasonController;
  final TextEditingController foodVariesWithMoodController;
  final TextEditingController hasDietPlanController;
  final TextEditingController consumesAlcoholController;
  final TextEditingController smokesController;
  final TextEditingController previousPhysicalActivityController;
  final TextEditingController currentPhysicalActivityController;
  final TextEditingController currentSportsInjuryDurationController;
  final TextEditingController isPregnantController;

  @override
  EatingHabitsState createState() => EatingHabitsState();
}

class EatingHabitsState extends State<EatingHabits> {
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
                title: 'Cuántas comidas consumes al día?',
                labelColor: AppColors.black100,
                hintText: '',
                typeTextField: TextFieldType.number,
                controller: widget.numberOfMealsController,
                fontSize: SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  nutritionalInfoProvider.setNumberOfMeals(int.parse(value));
                },
              ),
              CustomTextField(
                title: 'Alergias a medicamentos',
                labelColor: AppColors.black100,
                hintText: 'Penicilina, aspirina, etc.',
                typeTextField: TextFieldType.alphanumeric,
                controller: widget.medicationAllergyController,
                fontSize: SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  nutritionalInfoProvider.setMedicationAllergy(value);
                },
              ),
              CustomTextField(
                title: '¿Tomas algún suplemento?',
                labelColor: AppColors.black100,
                hintText: '',
                typeTextField: TextFieldType.boolean,
                controller: widget.takesSupplementController,
                fontSize: SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  if (value == 'SI') {
                    nutritionalInfoProvider.setTakesSupplement(true);
                  } else {
                    nutritionalInfoProvider.setTakesSupplement(false);
                  }
                },
              ),
              if (nutritionalInfoProvider.takesSupplement)
                Column(
                  children: [
                    CustomTextField(
                      title: '¿Cuál suplemento tomas?',
                      labelColor: AppColors.black100,
                      hintText: 'Proteína, creatina, etc.',
                      typeTextField: TextFieldType.alphanumeric,
                      controller: widget.supplementNameController,
                      fontSize: SizeConfig.scaleText(1.7),
                      onChanged: (value) {
                        nutritionalInfoProvider.setSupplementName(value);
                      },
                    ),
                    CustomTextField(
                      title: 'Dosis del suplemento',
                      labelColor: AppColors.black100,
                      hintText: '1 ml, 1 pastilla, etc.',
                      typeTextField: TextFieldType.alphanumeric,
                      controller: widget.supplementDoseController,
                      fontSize: SizeConfig.scaleText(1.7),
                      onChanged: (value) {
                        nutritionalInfoProvider.setSupplementDose(value);
                      },
                    ),
                    CustomTextField(
                      title: '¿Por qué tomas el suplemento?',
                      labelColor: AppColors.black100,
                      hintText: '',
                      typeTextField: TextFieldType.alphanumeric,
                      controller: widget.supplementReasonController,
                      fontSize: SizeConfig.scaleText(1.7),
                      onChanged: (value) {
                        nutritionalInfoProvider.setSupplementReason(value);
                      },
                    ),
                  ],
                ),
              CustomTextField(
                title:
                    '¿Tu alimentación varía con tu ánimo?',
                labelColor: AppColors.black100,
                hintText: '',
                typeTextField: TextFieldType.boolean,
                controller: widget.foodVariesWithMoodController,
                fontSize: SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  if (value == 'SI') {
                    nutritionalInfoProvider.setFoodVariesWithMood(true);
                  } else {
                    nutritionalInfoProvider.setFoodVariesWithMood(false);
                  }
                },
              ),
              CustomTextField(
                title: '¿Has llevado un plan de alimentación?',
                labelColor: AppColors.black100,
                hintText: '',
                typeTextField: TextFieldType.boolean,
                controller: widget.hasDietPlanController,
                fontSize: SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  if (value == 'SI') {
                    nutritionalInfoProvider.setHasDietPlan(true);
                  } else {
                    nutritionalInfoProvider.setHasDietPlan(false);
                  }
                },
              ),
              CustomTextField(
                title: '¿Consumes alcohol?',
                labelColor: AppColors.black100,
                hintText: '',
                typeTextField: TextFieldType.boolean,
                controller: widget.consumesAlcoholController,
                fontSize: SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  if (value == 'SI') {
                    nutritionalInfoProvider.setConsumesAlcohol(true);
                  } else {
                    nutritionalInfoProvider.setConsumesAlcohol(false);
                  }
                },
              ),
              CustomTextField(
                title: '¿Fumas?',
                labelColor: AppColors.black100,
                hintText: '',
                typeTextField: TextFieldType.boolean,
                controller: widget.smokesController,
                fontSize: SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  if (value == 'SI') {
                    nutritionalInfoProvider.setSmokes(true);
                  } else {
                    nutritionalInfoProvider.setSmokes(false);
                  }
                },
              ),
              CustomTextField(
                title: '¿Has realizado actividad física antes?',
                labelColor: AppColors.black100,
                hintText: '',
                typeTextField: TextFieldType.boolean,
                controller: widget.previousPhysicalActivityController,
                fontSize: SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  if (value == 'SI') {
                    nutritionalInfoProvider.setPreviousPhysicalActivity(true);
                  } else {
                    nutritionalInfoProvider.setPreviousPhysicalActivity(false);
                  }
                },
              ),
              CustomTextField(
                title: '¿Estás embarazada?',
                labelColor: AppColors.black100,
                hintText: '',
                typeTextField: TextFieldType.boolean,
                controller: widget.isPregnantController,
                fontSize: SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  if (value == 'SI') {
                    nutritionalInfoProvider.setIsPregnant(true);
                  } else {
                    nutritionalInfoProvider.setIsPregnant(false);
                  }
                },
              ),
              CustomTextField(
                title: '¿Tienes alguna lesión deportiva actualmente?',
                labelColor: AppColors.black100,
                hintText: '',
                typeTextField: TextFieldType.boolean,
                controller: widget.currentPhysicalActivityController,
                fontSize: SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  if (value == 'SI') {
                    nutritionalInfoProvider.setCurrentPhysicalActivity(true);
                  } else {
                    nutritionalInfoProvider.setCurrentPhysicalActivity(false);
                  }
                },
              ),
              if (nutritionalInfoProvider.currentPhysicalActivity)
              CustomTextField(
                title: '¿Hace cuánto tiempo ocurrió la lesión?',
                labelColor: AppColors.black100,
                hintText: '',
                typeTextField: TextFieldType.alphanumeric,
                controller: widget.currentSportsInjuryDurationController,
                fontSize: SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  nutritionalInfoProvider.setCurrentSportsInjuryDuration(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
