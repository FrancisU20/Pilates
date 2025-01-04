import 'package:flutter/material.dart';
import 'package:pilates/providers/register/register_provider.dart';
import 'package:pilates/screens/common/onboarding/widgets/step_1.dart';
import 'package:pilates/screens/common/onboarding/widgets/step_2.dart';
import 'package:pilates/screens/common/onboarding/widgets/step_3.dart';
import 'package:pilates/theme/utils/functions.dart';
import 'package:pilates/theme/widgets/custom_stepper_widget.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/theme/widgets/custom_button.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/widgets/custom_text_button.dart';
import 'package:provider/provider.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  OnboardingPageState createState() => OnboardingPageState();
}

class OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();

  int currentStep = 0;

  void _incrementCounter() {
    RegisterProvider registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);
    if (currentStep < 2) {
      setState(() {
        currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      registerProvider.clearData();
      smoothTransition(context, '/register');
    }
  }

  void _decrementCounter() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white100,
      appBar: AppBar(
        backgroundColor: AppColors.white100,
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const ClampingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.scaleWidth(8),
            ),
            color: AppColors.white100,
            height: SizeConfig.scaleHeight(100),
            width: SizeConfig.scaleWidth(100),
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.scaleHeight(65),
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (int index) {
                      setState(() {
                        currentStep = index;
                      });
                    },
                    children: const [
                      Step1(),
                      Step2(),
                      Step3(),
                    ],
                  ),
                ),
                CustomStepperWidget(currentStep: currentStep, totalSteps: 3),
                SizedBox(
                  height: SizeConfig.scaleHeight(4),
                ),
                CustomButton(
                  text: 'Siguiente',
                  onPressed: _incrementCounter,
                  color: AppColors.brown200,
                ),
                currentStep != 0
                    ? CustomTextButton(
                        text: 'Regresar',
                        onPressed: _decrementCounter,
                        color: AppColors.brown200,
                      )
                    : CustomTextButton(
                        text: 'Ya dispones de una cuenta, Inicia Sesión',
                        onPressed: () => {
                          smoothTransition(
                              context, '/login', )
                        },
                        color: AppColors.brown200,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
