import 'package:flutter/material.dart';
import 'package:pilates/providers/register_provider.dart';
import 'package:pilates/screens/onboarding/pages/onboarding_page1.dart';
import 'package:pilates/screens/onboarding/pages/onboarding_page2.dart';
import 'package:pilates/screens/onboarding/pages/onboarding_page3.dart';
import 'package:pilates/screens/onboarding/widgets/stepper_widget.dart';
import 'package:pilates/theme/colors_palette.dart';
import 'package:pilates/theme/widgets/buttons.dart';
import 'package:pilates/theme/widgets/images_containers.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/size_config.dart';
import 'package:provider/provider.dart';

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
      registerProvider.clearAll();
      Navigator.pushNamed(context, '/register');
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
      backgroundColor: ColorsPalette.white,
      appBar: AppBar(
        backgroundColor: ColorsPalette.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const ClampingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 8 * SizeConfig.widthMultiplier,
            ),
            color: ColorsPalette.white,
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
                  color: ColorsPalette.greyChocolate,
                ),
                currentStep != 0
                    ? buttons.underlineText(
                        text: 'Regresar',
                        onPressed: _decrementCounter,
                        color: ColorsPalette.greyChocolate,
                      )
                    : buttons.underlineText(
                        text: 'Ya dispones de una cuenta, Inicia Sesión',
                        onPressed: () => {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/login', (route) => false)
                            },
                        color: ColorsPalette.greyChocolate)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
