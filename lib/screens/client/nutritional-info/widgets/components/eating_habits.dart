import 'package:flutter/material.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/providers/login/login_provider.dart';
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

    //! agregar viewMode
    this.viewMode = false,
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

  // ! agregar viewMode
  final bool? viewMode;

  @override
  EatingHabitsState createState() => EatingHabitsState();
}

class EatingHabitsState extends State<EatingHabits> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NutritionalInfoProvider nutritionalInfoProvider =
        Provider.of<NutritionalInfoProvider>(context, listen: false);
    LoginProvider loginProvider = Provider.of<LoginProvider>(context, listen: false);
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
                    text: 'Hábitos alimenticios',
                    color: AppColors.black100,
                    fontSize:SizeConfig.scaleText(2),
                    fontWeight: FontWeight.w500,
                    maxLines: 2,),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(1),
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(1),
              ),
              CustomTextField(
                title: 'Cuántas comidas consumes al día?',
                labelColor: AppColors.black100,
                hintText: '',
                typeTextField: TextFieldType.numberInt,
                controller: widget.numberOfMealsController,
                fontSize:SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                  nutritionalInfoProvider.setNumberOfMeals(int.parse(value));
                  }
                  else {
                    nutritionalInfoProvider.setNumberOfMeals(0);
                  }
                },
                isActive: widget.viewMode == true ? false : true,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(1),
              ),
              CustomTextField(
                title: 'Alergias a medicamentos',
                labelColor: AppColors.black100,
                hintText: 'Penicilina, aspirina, etc.',
                typeTextField: TextFieldType.alphanumeric,
                controller: widget.medicationAllergyController,
                fontSize:SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  nutritionalInfoProvider.setMedicationAllergy(value);
                },
                isActive: widget.viewMode == true ? false : true,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(1),
              ),
              CustomTextField(
                title: '¿Tomas algún suplemento?',
                labelColor: AppColors.black100,
                hintText: '',
                typeTextField: TextFieldType.boolean,
                controller: widget.takesSupplementController,
                fontSize:SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  if (value == 'Sí') {
                    nutritionalInfoProvider.setTakesSupplement(true);
                  } else {
                    nutritionalInfoProvider.setTakesSupplement(false);
                  }
                },
                isActive: widget.viewMode == true ? false : true,
              ),
              if (nutritionalInfoProvider.takesSupplement == true)
                Column(
                  children: [
                    SizedBox(
                height: SizeConfig.scaleHeight(1),
              ),
              CustomTextField(
                      title: '¿Cuál suplemento tomas?',
                      labelColor: AppColors.black100,
                      hintText: 'Proteína, creatina, etc.',
                      typeTextField: TextFieldType.alphanumeric,
                      controller: widget.supplementNameController,
                      fontSize:SizeConfig.scaleText(1.7),
                      onChanged: (value) {
                        nutritionalInfoProvider.setSupplementName(value);
                      },
                      isActive: widget.viewMode == true ? false : true,
                    ),
                    SizedBox(
                height: SizeConfig.scaleHeight(1),
              ),
              CustomTextField(
                      title: 'Dosis del suplemento',
                      labelColor: AppColors.black100,
                      hintText: '1 ml, 1 pastilla, etc.',
                      typeTextField: TextFieldType.alphanumeric,
                      controller: widget.supplementDoseController,
                      fontSize:SizeConfig.scaleText(1.7),
                      onChanged: (value) {
                        nutritionalInfoProvider.setSupplementDose(value);
                      },
                      isActive: widget.viewMode == true ? false : true,
                    ),
                    SizedBox(
                height: SizeConfig.scaleHeight(1),
              ),
              CustomTextField(
                      title: '¿Por qué tomas el suplemento?',
                      labelColor: AppColors.black100,
                      hintText: '',
                      typeTextField: TextFieldType.alphanumeric,
                      controller: widget.supplementReasonController,
                      fontSize:SizeConfig.scaleText(1.7),
                      onChanged: (value) {
                        nutritionalInfoProvider.setSupplementReason(value);
                      },
                      isActive: widget.viewMode == true ? false : true,
                    ),
                  ],
                ),
              SizedBox(
                height: SizeConfig.scaleHeight(1),
              ),
              CustomTextField(
                title:
                    '¿Tu alimentación varía con tu ánimo?',
                labelColor: AppColors.black100,
                hintText: '',
                typeTextField: TextFieldType.boolean,
                controller: widget.foodVariesWithMoodController,
                fontSize:SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  if (value == 'Sí') {
                    nutritionalInfoProvider.setFoodVariesWithMood(true);
                  } else {
                    nutritionalInfoProvider.setFoodVariesWithMood(false);
                  }
                },
                isActive: widget.viewMode == true ? false : true,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(1),
              ),
              CustomTextField(
                title: '¿Has llevado un plan de alimentación?',
                labelColor: AppColors.black100,
                hintText: '',
                typeTextField: TextFieldType.boolean,
                controller: widget.hasDietPlanController,
                fontSize:SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  if (value == 'Sí') {
                    nutritionalInfoProvider.setHasDietPlan(true);
                  } else {
                    nutritionalInfoProvider.setHasDietPlan(false);
                  }
                },
                isActive: widget.viewMode == true ? false : true,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(1),
              ),
              CustomTextField(
                title: '¿Consumes alcohol?',
                labelColor: AppColors.black100,
                hintText: '',
                typeTextField: TextFieldType.boolean,
                controller: widget.consumesAlcoholController,
                fontSize:SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  if (value == 'Sí') {
                    nutritionalInfoProvider.setConsumesAlcohol(true);
                  } else {
                    nutritionalInfoProvider.setConsumesAlcohol(false);
                  }
                },
                isActive: widget.viewMode == true ? false : true,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(1),
              ),
              CustomTextField(
                title: '¿Fumas?',
                labelColor: AppColors.black100,
                hintText: '',
                typeTextField: TextFieldType.boolean,
                controller: widget.smokesController,
                fontSize:SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  if (value == 'Sí') {
                    nutritionalInfoProvider.setSmokes(true);
                  } else {
                    nutritionalInfoProvider.setSmokes(false);
                  }
                },
                isActive: widget.viewMode == true ? false : true,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(1),
              ),
              CustomTextField(
                title: '¿Has realizado actividad física antes?',
                labelColor: AppColors.black100,
                hintText: '',
                typeTextField: TextFieldType.boolean,
                controller: widget.previousPhysicalActivityController,
                fontSize:SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  if (value == 'Sí') {
                    nutritionalInfoProvider.setPreviousPhysicalActivity(true);
                  } else {
                    nutritionalInfoProvider.setPreviousPhysicalActivity(false);
                  }
                },
                isActive: widget.viewMode == true ? false : true,
              ),
              if(loginProvider.user!.gender != 'M')
              SizedBox(
                height: SizeConfig.scaleHeight(1),
              ),
              CustomTextField(
                title: '¿Estás embarazada?',
                labelColor: AppColors.black100,
                hintText: '',
                typeTextField: TextFieldType.boolean,
                controller: widget.isPregnantController,
                fontSize:SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  if (value == 'Sí') {
                    nutritionalInfoProvider.setIsPregnant(true);
                  } else {
                    nutritionalInfoProvider.setIsPregnant(false);
                  }
                },
                isActive: widget.viewMode == true ? false : true,
              ),
              SizedBox(
                height: SizeConfig.scaleHeight(1),
              ),
              CustomTextField(
                title: '¿Tienes alguna lesión deportiva actualmente?',
                labelColor: AppColors.black100,
                hintText: '',
                typeTextField: TextFieldType.boolean,
                controller: widget.currentPhysicalActivityController,
                fontSize:SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  if (value == 'Sí') {
                    nutritionalInfoProvider.setCurrentPhysicalInjury(true);
                  } else {
                    nutritionalInfoProvider.setCurrentPhysicalInjury(false);
                  }
                },
                isActive: widget.viewMode == true ? false : true,
              ),
              if (nutritionalInfoProvider.currentPhysicalInjury == true)
              SizedBox(
                height: SizeConfig.scaleHeight(1),
              ),
              CustomTextField(
                title: '¿Hace cuánto tiempo ocurrió la lesión?',
                labelColor: AppColors.black100,
                hintText: '',
                typeTextField: TextFieldType.alphanumeric,
                controller: widget.currentSportsInjuryDurationController,
                fontSize:SizeConfig.scaleText(1.7),
                onChanged: (value) {
                  nutritionalInfoProvider.setCurrentSportsInjuryDuration(value);
                },
                isActive: widget.viewMode == true ? false : true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
