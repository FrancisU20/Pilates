import 'package:flutter/material.dart';
import 'package:pilates/providers/register/register_provider.dart';
import 'package:pilates/screens/client/register/widgets/final_step.dart';
import 'package:pilates/screens/client/register/widgets/gender_step.dart';
import 'package:pilates/screens/client/register/widgets/personal_information_step.dart';
import 'package:pilates/screens/client/register/widgets/profile_picture_step.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/components/app_loading.dart';
import 'package:pilates/theme/widgets/custom_button.dart';
import 'package:pilates/theme/widgets/custom_snack_bar.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/widgets/custom_text_button.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dniController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    nameController.dispose();
    lastNameController.dispose();
    birthdayController.dispose();
    phoneController.dispose();
    dniController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.white100,
          appBar: AppBar(
            backgroundColor: AppColors.white100,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: AppColors.black100),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
              color: AppColors.white100,
            ),
            width: double.infinity,
            height: double.infinity,
            child: Consumer<RegisterProvider>(
              builder: (context, registerProvider, child) {
                return Stepper(
                  currentStep: registerProvider.currentStep,
                  controlsBuilder:
                      (BuildContext context, ControlsDetails controls) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (registerProvider.currentStep > 0 &&
                            registerProvider.currentStep < 3)
                          CustomTextButton(
                            onPressed: controls.onStepCancel!,
                            text: 'Atrás',
                            color: AppColors.brown200,
                          ),
                        if (registerProvider.currentStep < 3)
                          CustomButton(
                              onPressed: controls.onStepContinue!,
                              text: 'Siguiente',
                              width: SizeConfig.scaleWidth(10)),
                        if (registerProvider.currentStep == 3)
                          CustomButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/login', (route) => false);
                            },
                            text: 'Iniciar Sesión',
                            width: SizeConfig.scaleWidth(10),
                          ),
                      ],
                    );
                  },
                  onStepCancel: () {
                    if (registerProvider.currentStep > 0) {
                      registerProvider.previousStep();
                    }
                  },
                  onStepContinue: () async {
                    try {
                      if (registerProvider.currentStep == 0) {
                        await registerProvider.validateStep1(context);
                        if (!registerProvider.isStep1Completed) return;
                        registerProvider.nextStep();
                      } else if (registerProvider.currentStep == 1) {
                        await registerProvider.validateStep2(context);
                        if (!registerProvider.isStep2Completed) return;
                        registerProvider.nextStep();
                      } else if (registerProvider.currentStep == 2) {
                        await registerProvider.validateStep3(context);
                        if (!registerProvider.isStep3Completed) return;
                        if (!context.mounted) return;
                        await registerProvider.register(context);
                      }
                    } catch (e) {
                      if (!context.mounted) return;
                      CustomSnackBar.show(
                        context,
                        e.toString(),
                        SnackBarType.error,
                      );
                    }
                  },
                  steps: [
                    Step(
                      title: CustomText(
                          text: !registerProvider.isStep1Completed
                              ? 'Registro'
                              : 'Completado',
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.scaleText(2.7)),
                      content: PersonalInformationStep(
                        emailController: emailController,
                        passwordController: passwordController,
                        repeatPasswordController: repeatPasswordController,
                        nameController: nameController,
                        lastNameController: lastNameController,
                        birthdayController: birthdayController,
                        phoneController: phoneController,
                        dniController: dniController,
                      ),
                      isActive: registerProvider.currentStep >= 0,
                      state: registerProvider.isStep1Completed
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: CustomText(
                          text: !registerProvider.isStep2Completed
                              ? 'Cuál es tu género?'
                              : 'Completado',
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.scaleText(2.7)),
                      content: const GenderStep(),
                      isActive: registerProvider.currentStep >= 1,
                      state: registerProvider.isStep2Completed
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: CustomText(
                          text: !registerProvider.isStep3Completed
                              ? 'Sube una foto de perfil'
                              : 'Completado',
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.scaleText(2.7)),
                      content: const ProfilePictureStep(),
                      isActive: registerProvider.currentStep >= 2,
                      state: registerProvider.isStep3Completed
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: CustomText(
                          text: registerProvider.currentStep == 3
                              ? 'Registro Exitoso'
                              : 'En Proceso',
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.scaleText(2.7)),
                      content: const FinalStep(),
                      state: StepState.complete,
                      isActive: registerProvider.currentStep == 3,
                    )
                  ],
                );
              },
            ),
          ),
        ),
        Consumer<RegisterProvider>(
          builder: (context, registerProvider, child) {
            if (registerProvider.isLoading) {
              return const AppLoading();
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
