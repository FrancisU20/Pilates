import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/providers/nutritional-info/nutritional_info_provider.dart';
import 'package:pilates/screens/client/nutritional-info/widgets/components/anthropometric_data.dart';
import 'package:pilates/screens/client/nutritional-info/widgets/components/confirm_nutritional_info.dart';
import 'package:pilates/screens/client/nutritional-info/widgets/components/diseases.dart';
import 'package:pilates/screens/client/nutritional-info/widgets/components/eating_habits.dart';
import 'package:pilates/screens/client/nutritional-info/widgets/components/personal_info.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_button.dart';
import 'package:pilates/theme/widgets/custom_icon_button.dart';
import 'package:pilates/theme/widgets/custom_stepper_widget.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/theme/widgets/custom_text_button.dart';
import 'package:provider/provider.dart';

class NutritionalSheet extends StatefulWidget {
  const NutritionalSheet({
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
    required this.diabetesController,
    required this.dyslipidemiasController,
    required this.obesityController,
    required this.hypertensionController,
    required this.cancerController,
    required this.hypoHyperthyroidismController,
    required this.otherConditionsController,
    required this.weightController,
    required this.heightController,
    required this.neckCircumferenceController,
    required this.waistCircumferenceController,
    required this.hipCircumferenceController,
    //! Se agrega un campo llamado viewMode
    this.viewMode = false,
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
  final TextEditingController diabetesController;
  final TextEditingController dyslipidemiasController;
  final TextEditingController obesityController;
  final TextEditingController hypertensionController;
  final TextEditingController cancerController;
  final TextEditingController hypoHyperthyroidismController;
  final TextEditingController otherConditionsController;
  final TextEditingController weightController;
  final TextEditingController heightController;
  final TextEditingController neckCircumferenceController;
  final TextEditingController waistCircumferenceController;
  final TextEditingController hipCircumferenceController;

  //! Se agrega un campo llamado viewMode
  final bool? viewMode;

  @override
  NutritionalSheetState createState() => NutritionalSheetState();
}

class NutritionalSheetState extends State<NutritionalSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.scaleWidth(5),
            vertical: SizeConfig.scaleHeight(2)),
        decoration: const BoxDecoration(
          color: AppColors.white100,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        height: SizeConfig.scaleHeight(100),
        width: SizeConfig.scaleWidth(100),
        child: Consumer<NutritionalInfoProvider>(
          builder: (context, nutritionalInfoProvider, child) {
            int currentStep = nutritionalInfoProvider.currentStep;
            return ListView(
              children: [
                if (widget.viewMode == true) ...[
                  Row(
                    children: [
                      CustomText(
                        text: 'Modo Visualización',
                        fontSize: SizeConfig.scaleText(2.5),
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey200,
                      ),
                      const Spacer(),
                      CustomIconButton(
                          icon: FontAwesomeIcons.penToSquare,
                          iconSize: 2,
                          width: 10,
                          height: 5,
                          isCircle: true,
                          radius: 50,
                          onPressed: () {
                            nutritionalInfoProvider.setCurrentStep(0);
                            nutritionalInfoProvider.setIsEditable(true);
                          })
                    ],
                  ),
                ] else if (widget.viewMode == false)
                  Row(
                    children: [
                      CustomText(
                        text: 'Modo Edición',
                        fontSize: SizeConfig.scaleText(2.5),
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey200,
                      ),
                      const Spacer(),
                      CustomIconButton(
                          icon: FontAwesomeIcons.xmark,
                          iconSize: 2,
                          width: 10,
                          height: 5,
                          isCircle: true,
                          radius: 50,
                          onPressed: () {
                            nutritionalInfoProvider.setCurrentStep(0);
                            nutritionalInfoProvider.setIsEditable(false);
                          })
                    ],
                  ),
                SizedBox(
                  height: SizeConfig.scaleHeight(1.5),
                ),
                CustomStepperWidget(
                  currentStep: currentStep,
                  totalSteps: widget.viewMode! ? 4 : 5,
                ),
                SizedBox(
                  height: SizeConfig.scaleHeight(2),
                ),
                if (currentStep == 0) //! OJO CON ESTO
                  PersonalInformation(
                      completeNameController: widget.completeNameController,
                      birthDateController: widget.birthDateController,
                      ageController: widget.ageController,
                      genderController: widget.genderController,
                      maritalStatusController: widget.maritalStatusController,
                      addressController: widget.addressController,
                      occupationController: widget.occupationController,
                      phoneController: widget.phoneController,
                      emailController: widget.emailController,
                      viewMode: widget.viewMode)
                else if (currentStep == 1) //! OJO CON ESTO
                  EatingHabits(
                      numberOfMealsController: widget.numberOfMealsController,
                      medicationAllergyController:
                          widget.medicationAllergyController,
                      takesSupplementController:
                          widget.takesSupplementController,
                      supplementNameController: widget.supplementNameController,
                      supplementDoseController: widget.supplementDoseController,
                      supplementReasonController:
                          widget.supplementReasonController,
                      foodVariesWithMoodController:
                          widget.foodVariesWithMoodController,
                      hasDietPlanController: widget.hasDietPlanController,
                      consumesAlcoholController:
                          widget.consumesAlcoholController,
                      smokesController: widget.smokesController,
                      previousPhysicalActivityController:
                          widget.previousPhysicalActivityController,
                      currentPhysicalActivityController:
                          widget.currentPhysicalActivityController,
                      currentSportsInjuryDurationController:
                          widget.currentSportsInjuryDurationController,
                      isPregnantController: widget.isPregnantController,
                      viewMode: widget.viewMode)
                else if (currentStep == 2)
                  Diseases(
                      diabetesController: widget.diabetesController,
                      dyslipidemiasController: widget.dyslipidemiasController,
                      obesityController: widget.obesityController,
                      hypertensionController: widget.hypertensionController,
                      cancerController: widget.cancerController,
                      hypoHyperthyroidismController:
                          widget.hypoHyperthyroidismController,
                      otherConditionsController:
                          widget.otherConditionsController,
                      viewMode: widget.viewMode)
                else if (currentStep == 3)
                  AnthropometricData(
                      weightController: widget.weightController,
                      heightController: widget.heightController,
                      neckCircumferenceController:
                          widget.neckCircumferenceController,
                      waistCircumferenceController:
                          widget.waistCircumferenceController,
                      hipCircumferenceController:
                          widget.hipCircumferenceController,
                      viewMode: widget.viewMode)
                else if (currentStep == 4 && !widget.viewMode!)
                  const ConfirmNutritionalInfo(),
                if (currentStep == 3 && widget.viewMode!) ...[
                  CustomButton(
                      onPressed: () {
                        nutritionalInfoProvider.generatePdf(context);
                      },
                      text: 'Descargar PDF',
                      color: AppColors.brown200),
                ] else if (currentStep < 4) ...[
                  Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.scaleHeight(2),
                      ),
                      CustomButton(
                          onPressed: () async {
                            if (currentStep == 3) {
                              await nutritionalInfoProvider
                                  .validateNutritionalInfo(context);
                            }
                            if (currentStep == 3 &&
                                nutritionalInfoProvider.validateForm == true &&
                                !widget.viewMode!) {
                              nutritionalInfoProvider.nextStep();
                            }
                            if (currentStep < 3) {
                              nutritionalInfoProvider.nextStep();
                            }
                          },
                          text: 'Siguiente',
                          color: AppColors.brown200),
                    ],
                  ),
                ],
                if (currentStep > 0) ...[
                  CustomTextButton(
                    onPressed: () {
                      if (currentStep != 0) {
                        nutritionalInfoProvider.previousStep();
                      }
                    },
                    text: 'Regresar',
                  )
                ]
              ],
            );
          },
        ),
      ),
    );
  }
}
