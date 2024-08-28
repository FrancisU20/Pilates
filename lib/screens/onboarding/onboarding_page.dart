import 'package:flutter/material.dart';
import 'package:pilates/screens/onboarding/pages/onboarding_page1.dart';
import 'package:pilates/screens/onboarding/pages/onboarding_page2.dart';
import 'package:pilates/screens/onboarding/pages/onboarding_page3.dart';
import 'package:pilates/screens/onboarding/widgets/stepper_widget.dart';
import 'package:pilates/screens/subscription/plans_page.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/widgets/buttons.dart';
import 'package:pilates/theme/widgets/images_containers.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  OnboardingPageState createState() => OnboardingPageState();
}

class OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  Buttons buttons = Buttons();
  Texts texts = Texts();
  ImagesContainers imagesContainers = ImagesContainers();

  int currentStep = 0;

  void _incrementCounter() {
    if (currentStep < 2) {
      setState(() {
        currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SubscriptionPage()),
          (route) => false);
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
      appBar: AppBar(
        backgroundColor: ColorsPalette.backgroundColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 8 * SizeConfig.widthMultiplier,
            ),
            color: ColorsPalette.backgroundColor,
            height: 100 * SizeConfig.heightMultiplier,
            width: 100 * SizeConfig.widthMultiplier,
            child: Column(
              children: [
                SizedBox(
                  height: 65 * SizeConfig.heightMultiplier,
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
                StepperWidget(currentStep: currentStep, totalSteps: 3),
                SizedBox(height: 4 * SizeConfig.heightMultiplier),
                buttons.standart(
                  text: 'Siguiente',
                  onPressed: _incrementCounter,
                  color: ColorsPalette.primaryColor,
                ),
                currentStep != 0
                    ? buttons.undelineText(
                        text: 'Regresar',
                        onPressed: _decrementCounter,
                        color: ColorsPalette.secondaryColor,
                      )
                    : const SizedBox.shrink(),
                buttons.undelineText(
                    text: 'Ya dispones de una cuenta, Inicia Sesión',
                    onPressed: () => {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', (route) => false)
                        },
                    color: ColorsPalette.textColor)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
