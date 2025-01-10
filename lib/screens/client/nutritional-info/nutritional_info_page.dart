import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/providers/nutritional-info/nutritional_info_provider.dart';
import 'package:pilates/screens/client/nutritional-info/widgets/nutritional_sheet.dart';
import 'package:pilates/theme/components/common/app_empty_data.dart';
import 'package:pilates/theme/components/common/app_loading.dart';
import 'package:pilates/theme/components/common/custom_app_bar.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_page_header.dart';
import 'package:pilates/config/size_config.dart';
import 'package:provider/provider.dart';

class NutritionalInfoPage extends StatefulWidget {
  const NutritionalInfoPage({super.key});

  @override
  NutritionalInfoPageState createState() => NutritionalInfoPageState();
}

class NutritionalInfoPageState extends State<NutritionalInfoPage> {
  //? Informacion Personal
  TextEditingController completeNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  //? Hábitos Alimenticios
  TextEditingController numberOfMealsController = TextEditingController();
  TextEditingController medicationAllergyController = TextEditingController();
  TextEditingController takesSupplementController = TextEditingController();
  TextEditingController supplementNameController = TextEditingController();
  TextEditingController supplementDoseController = TextEditingController();
  TextEditingController supplementReasonController = TextEditingController();
  TextEditingController foodVariesWithMoodController = TextEditingController();
  TextEditingController hasDietPlanController = TextEditingController();
  TextEditingController consumesAlcoholController = TextEditingController();
  TextEditingController smokesController = TextEditingController();
  TextEditingController previousPhysicalActivityController =
      TextEditingController();
  TextEditingController currentPhysicalActivityController =
      TextEditingController();
  TextEditingController currentSportsInjuryDurationController =
      TextEditingController();
  TextEditingController isPregnantController = TextEditingController();

  //? Antecedentes Heredofamiliares
  TextEditingController diabetesController = TextEditingController();
  TextEditingController dyslipidemiasController = TextEditingController();
  TextEditingController obesityController = TextEditingController();
  TextEditingController hypertensionController = TextEditingController();
  TextEditingController cancerController = TextEditingController();
  TextEditingController hypoHyperthyroidismController = TextEditingController();
  TextEditingController otherConditionsController = TextEditingController();

  //? Medidas Antropométricas
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController neckCircumferenceController = TextEditingController();
  TextEditingController waistCircumferenceController = TextEditingController();
  TextEditingController hipCircumferenceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      NutritionalInfoProvider nutritionalInfoProvider =
          Provider.of<NutritionalInfoProvider>(context, listen: false);
      nutritionalInfoProvider.reset();
      await nutritionalInfoProvider.getUserNutritionalInfo(context);
      await nutritionalInfoProvider.fillNutritionalInfo();
      await nutritionalInfoProvider.updateAllTextEditingControllers(
          completeNameController,
          birthDateController,
          ageController,
          genderController,
          maritalStatusController,
          addressController,
          occupationController,
          phoneController,
          emailController,
          numberOfMealsController,
          medicationAllergyController,
          takesSupplementController,
          supplementNameController,
          supplementDoseController,
          supplementReasonController,
          foodVariesWithMoodController,
          hasDietPlanController,
          consumesAlcoholController,
          smokesController,
          previousPhysicalActivityController,
          currentPhysicalActivityController,
          currentSportsInjuryDurationController,
          isPregnantController,
          diabetesController,
          dyslipidemiasController,
          obesityController,
          hypertensionController,
          cancerController,
          hypoHyperthyroidismController,
          otherConditionsController,
          weightController,
          heightController,
          neckCircumferenceController,
          waistCircumferenceController,
          hipCircumferenceController);
    });
  }

  @override
  void dispose() {
    //? Información Personal
    completeNameController.dispose();
    birthDateController.dispose();
    ageController.dispose();
    genderController.dispose();
    maritalStatusController.dispose();
    addressController.dispose();
    occupationController.dispose();
    phoneController.dispose();
    emailController.dispose();

    //? Hábitos Alimenticios
    numberOfMealsController.dispose();
    medicationAllergyController.dispose();
    takesSupplementController.dispose();
    supplementNameController.dispose();
    supplementDoseController.dispose();
    supplementReasonController.dispose();
    foodVariesWithMoodController.dispose();
    hasDietPlanController.dispose();
    consumesAlcoholController.dispose();
    smokesController.dispose();
    previousPhysicalActivityController.dispose();
    currentPhysicalActivityController.dispose();
    currentSportsInjuryDurationController.dispose();
    isPregnantController.dispose();

    //? Antecedentes Heredofamiliares
    diabetesController.dispose();
    dyslipidemiasController.dispose();
    obesityController.dispose();
    hypertensionController.dispose();
    cancerController.dispose();
    hypoHyperthyroidismController.dispose();
    otherConditionsController.dispose();

    //? Medidas Antropométricas
    weightController.dispose();
    heightController.dispose();
    neckCircumferenceController.dispose();
    waistCircumferenceController.dispose();
    hipCircumferenceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: AppColors.brown200,
            appBar: const CustomAppBar(
                backgroundColor: AppColors.brown200, ),
            body: Container(
              color: AppColors.brown200,
              child: Column(
                children: [
                  const CustomPageHeader(
                      icon: FontAwesomeIcons.clipboardList,
                      title: 'Ficha Nutricional',
                      subtitle: 'Ingresa o actualiza tu información'),
                  SizedBox(
                    height: SizeConfig.scaleHeight(2),
                  ),
                  Consumer<NutritionalInfoProvider>(
                    builder: (context, nutritionalInfoProvider, child) {
                      if (nutritionalInfoProvider.nutritionalInfo == null &&
                          nutritionalInfoProvider.isEditable == false) {
                        return AppEmptyData(
                            imagePath:
                                'https://curvepilates-bucket.s3.amazonaws.com/app-assets/clipboard/empty-clipboard.png',
                            message:
                                'Aún no has completado tu ficha nutricional. Crea una nueva y agrega tu información.',
                            buttonText: 'Crear Ficha',
                            onButtonPressed: () {
                              nutritionalInfoProvider.setIsEditable(true);
                            },
                            buttonIcon: FontAwesomeIcons.plus);
                      } else if (nutritionalInfoProvider.nutritionalInfo !=
                              null &&
                          nutritionalInfoProvider.isEditable == false) {
                        return NutritionalSheet(
                          completeNameController: completeNameController,
                          birthDateController: birthDateController,
                          ageController: ageController,
                          genderController: genderController,
                          maritalStatusController: maritalStatusController,
                          addressController: addressController,
                          occupationController: occupationController,
                          phoneController: phoneController,
                          emailController: emailController,
                          numberOfMealsController: numberOfMealsController,
                          medicationAllergyController:
                              medicationAllergyController,
                          takesSupplementController: takesSupplementController,
                          supplementNameController: supplementNameController,
                          supplementDoseController: supplementDoseController,
                          supplementReasonController: supplementReasonController,
                          foodVariesWithMoodController:
                              foodVariesWithMoodController,
                          hasDietPlanController: hasDietPlanController,
                          consumesAlcoholController: consumesAlcoholController,
                          smokesController: smokesController,
                          previousPhysicalActivityController:
                              previousPhysicalActivityController,
                          isPregnantController: isPregnantController,
                          currentPhysicalActivityController:
                              currentPhysicalActivityController,
                          currentSportsInjuryDurationController:
                              currentSportsInjuryDurationController,
                          diabetesController: diabetesController,
                          dyslipidemiasController: dyslipidemiasController,
                          obesityController: obesityController,
                          hypertensionController: hypertensionController,
                          cancerController: cancerController,
                          hypoHyperthyroidismController:
                              hypoHyperthyroidismController,
                          otherConditionsController: otherConditionsController,
                          weightController: weightController,
                          heightController: heightController,
                          neckCircumferenceController:
                              neckCircumferenceController,
                          waistCircumferenceController:
                              waistCircumferenceController,
                          hipCircumferenceController: hipCircumferenceController,
                          viewMode: true,
                        );
                      } else {
                        return NutritionalSheet(
                            completeNameController: completeNameController,
                            birthDateController: birthDateController,
                            ageController: ageController,
                            genderController: genderController,
                            maritalStatusController: maritalStatusController,
                            addressController: addressController,
                            occupationController: occupationController,
                            phoneController: phoneController,
                            emailController: emailController,
                            numberOfMealsController: numberOfMealsController,
                            medicationAllergyController:
                                medicationAllergyController,
                            takesSupplementController: takesSupplementController,
                            supplementNameController: supplementNameController,
                            supplementDoseController: supplementDoseController,
                            supplementReasonController:
                                supplementReasonController,
                            foodVariesWithMoodController:
                                foodVariesWithMoodController,
                            hasDietPlanController: hasDietPlanController,
                            consumesAlcoholController: consumesAlcoholController,
                            smokesController: smokesController,
                            previousPhysicalActivityController:
                                previousPhysicalActivityController,
                            isPregnantController: isPregnantController,
                            currentPhysicalActivityController:
                                currentPhysicalActivityController,
                            currentSportsInjuryDurationController:
                                currentSportsInjuryDurationController,
                            diabetesController: diabetesController,
                            dyslipidemiasController: dyslipidemiasController,
                            obesityController: obesityController,
                            hypertensionController: hypertensionController,
                            cancerController: cancerController,
                            hypoHyperthyroidismController:
                                hypoHyperthyroidismController,
                            otherConditionsController: otherConditionsController,
                            weightController: weightController,
                            heightController: heightController,
                            neckCircumferenceController:
                                neckCircumferenceController,
                            waistCircumferenceController:
                                waistCircumferenceController,
                            hipCircumferenceController:
                                hipCircumferenceController);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          const AppLoading(),
        ],
      ),
    );
  }
}
