import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilates/providers/nutritional-info/nutritional_info_provider.dart';
import 'package:pilates/screens/client/nutritional-info/widgets/anthropometric_data.dart';
import 'package:pilates/screens/client/nutritional-info/widgets/confirm_nutritional_info.dart';
import 'package:pilates/screens/client/nutritional-info/widgets/diseases.dart';
import 'package:pilates/screens/client/nutritional-info/widgets/eating_habits.dart';
import 'package:pilates/screens/client/nutritional-info/widgets/personal_info.dart';
import 'package:pilates/theme/components/common/app_empty_data.dart';
import 'package:pilates/theme/components/common/app_loading.dart';
import 'package:pilates/theme/widgets/custom_app_bar.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_image_network.dart';
import 'package:pilates/theme/widgets/custom_page_header.dart';
import 'package:pilates/theme/widgets/custom_stepper_widget.dart';
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

  //? Controladores de paginador
  int currentStep = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NutritionalInfoProvider>(context, listen: false).clearData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.brown200,
          appBar: const CustomAppBar(backgroundColor: AppColors.brown200),
          body: Container(
            color: AppColors.brown200,
            child: Column(
              children: [
                const CustomPageHeader(
                    icon: FontAwesomeIcons.boxesStacked,
                    title: 'Ficha Nutricional',
                    subtitle: 'Ingresa o actualiza tu información'),
                SizedBox(
                  height: SizeConfig.scaleHeight(2),
                ),
                Consumer<NutritionalInfoProvider>(
                  builder: (context, nutritionalInfoProvider, child) {
                    if (nutritionalInfoProvider.hasNutritionalInfo == false) {
                      return AppEmptyData(
                          imagePath:
                              'https://curvepilates-bucket.s3.amazonaws.com/app-assets/clipboard/empty-clipboard.png',
                          message:
                              'Aún no has completado tu ficha nutricional. Crea una nueva y agrega tu información.',
                          buttonText: 'Crear Ficha',
                          onButtonPressed: () {
                            nutritionalInfoProvider.setHasNutritionalInfo(true);
                          },
                          buttonIcon: FontAwesomeIcons.plus);
                    } else {
                      return Flexible(
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: SizeConfig.scaleWidth(5),
                                vertical: SizeConfig.scaleHeight(2)),
                            decoration: const BoxDecoration(
                                color: AppColors.white100,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25))),
                            height: SizeConfig.scaleHeight(100),
                            width: SizeConfig.scaleWidth(100),
                            child: ListView(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        if (currentStep != 0) {
                                          setState(() {
                                            currentStep--;
                                          });
                                        }
                                      },
                                      icon: Icon(Icons.arrow_back_ios,
                                          size: SizeConfig.scaleHeight(4)),
                                      color: currentStep != 0
                                          ? AppColors.black100
                                          : AppColors.white100,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: SizeConfig.scaleWidth(5),
                                        vertical: SizeConfig.scaleHeight(2),
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.black100,
                                        borderRadius: BorderRadius.circular(
                                            SizeConfig.scaleWidth(2)),
                                        border: Border.all(
                                          color: AppColors.black100
                                              .withOpacity(0.1),
                                        ),
                                      ),
                                      child: CustomImageNetwork(
                                        imagePath:
                                            'https://curvepilates-bucket.s3.amazonaws.com/app-assets/logo/logo_rectangle_transparent_white.png',
                                        height: SizeConfig.scaleHeight(4),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        if (currentStep != 4) {
                                          setState(() {
                                            currentStep++;
                                          });
                                        }
                                      },
                                      icon: Icon(Icons.arrow_forward_ios,
                                          size: SizeConfig.scaleHeight(4)),
                                      color: currentStep != 4
                                          ? AppColors.black100
                                          : AppColors.white100,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.scaleHeight(2),
                                ),
                                CustomStepperWidget(
                                    currentStep: currentStep, totalSteps: 5),
                                SizedBox(
                                  height: SizeConfig.scaleHeight(2),
                                ),
                                if (currentStep == 0) //! OJO CON ESTO
                                  PersonalInformation(
                                      completeNameController:
                                          completeNameController,
                                      birthDateController: birthDateController,
                                      ageController: ageController,
                                      genderController: genderController,
                                      maritalStatusController:
                                          maritalStatusController,
                                      addressController: addressController,
                                      occupationController:
                                          occupationController,
                                      phoneController: phoneController,
                                      emailController: emailController)
                                else if (currentStep == 1) //! OJO CON ESTO
                                  EatingHabits(
                                      numberOfMealsController:
                                          numberOfMealsController,
                                      medicationAllergyController:
                                          medicationAllergyController,
                                      takesSupplementController:
                                          takesSupplementController,
                                      supplementNameController:
                                          supplementNameController,
                                      supplementDoseController:
                                          supplementDoseController,
                                      supplementReasonController:
                                          supplementReasonController,
                                      foodVariesWithMoodController:
                                          foodVariesWithMoodController,
                                      hasDietPlanController:
                                          hasDietPlanController,
                                      consumesAlcoholController:
                                          consumesAlcoholController,
                                      smokesController: smokesController,
                                      previousPhysicalActivityController:
                                          previousPhysicalActivityController,
                                      currentPhysicalActivityController:
                                          currentPhysicalActivityController,
                                      currentSportsInjuryDurationController:
                                          currentSportsInjuryDurationController,
                                      isPregnantController:
                                          isPregnantController)
                                else if (currentStep == 2)
                                  Diseases(
                                      diabetesController: diabetesController,
                                      dyslipidemiasController:
                                          dyslipidemiasController,
                                      obesityController: obesityController,
                                      hypertensionController:
                                          hypertensionController,
                                      cancerController: cancerController,
                                      hypoHyperthyroidismController:
                                          hypoHyperthyroidismController,
                                      otherConditionsController:
                                          otherConditionsController)
                                else if (currentStep == 3)
                                  AnthropometricData(
                                      weightController: weightController,
                                      heightController: heightController,
                                      neckCircumferenceController:
                                          neckCircumferenceController,
                                      waistCircumferenceController:
                                          waistCircumferenceController,
                                      hipCircumferenceController:
                                          hipCircumferenceController)
                                else if (currentStep == 4)
                                  const ConfirmNutritionalInfo()
                              ],
                            )),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        Consumer<NutritionalInfoProvider>(
          builder: (context, nutritionalInfoProvider, child) {
            if (nutritionalInfoProvider.isLoading) {
              return const AppLoading();
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
