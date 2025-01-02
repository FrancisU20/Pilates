import 'package:flutter/material.dart';
import 'package:pilates/providers/register/register_provider.dart';
import 'package:pilates/screens/client/register/widgets/final_step.dart';
import 'package:pilates/screens/client/register/widgets/gender_step.dart';
import 'package:pilates/screens/client/register/widgets/personal_information_step.dart';
import 'package:pilates/screens/client/register/widgets/profile_picture_step.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_snack_bar.dart';
import 'package:pilates/theme/widgets/custom_text.dart';
import 'package:pilates/config/size_config.dart';
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
    return Scaffold(
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
              onStepContinue: () {
                if (registerProvider.currentStep == 0) {
                  try {
                    registerProvider.validateStep1();
                    if (registerProvider.isStep1Completed) {
                      registerProvider.nextStep();
                    }
                  } catch (e) {
                    CustomSnackBar.show(
                      context,
                      e.toString(),
                      SnackBarType.error,
                    );
                    return;
                  }
                }
                if (registerProvider.currentStep == 1) {
                  try {
                    registerProvider.validateStep2();
                    if (registerProvider.isStep2Completed) {
                      registerProvider.nextStep();
                    }
                  } catch (e) {
                    CustomSnackBar.show(
                      context,
                      e.toString(),
                      SnackBarType.error,
                    );
                    return;
                  }
                }

                if (registerProvider.currentStep == 2) {
                  try {
                    registerProvider.validateStep3();
                    if (registerProvider.isStep3Completed) {
                      registerProvider.nextStep();
                    }
                  } catch (e) {
                    CustomSnackBar.show(
                      context,
                      e.toString(),
                      SnackBarType.error,
                    );
                    return;
                  }
                }
                
                if (registerProvider.currentStep == 3) {
                  Navigator.pop(context);
                }
              },
              steps: [
                Step(
                  title: CustomText(
                      text: !registerProvider.isStep1Completed ? 'Registro' : 'Completado',
                      fontWeight: FontWeight.w500, fontSize: SizeConfig.scaleText(3)),
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
                      fontWeight: FontWeight.w500, fontSize: SizeConfig.scaleText(3)),
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
                      fontWeight: FontWeight.w500, fontSize: SizeConfig.scaleText(3)),
                  content: const ProfilePictureStep(),
                  isActive: registerProvider.currentStep == 2,
                  state: registerProvider.isStep3Completed
                      ? StepState.complete
                      : StepState.indexed,
                ),
                Step(
                  title: CustomText(
                      text: registerProvider.currentStep == 3
                          ? 'Registro Exitoso'
                          : 'En Proceso',
                      fontWeight: FontWeight.w500, fontSize: SizeConfig.scaleText(3)),
                  content: const FinalStep(),
                  state: StepState.complete,
                  isActive: registerProvider.currentStep == 3,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
