import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pilates/screens/login/login_page.dart';
import 'package:pilates/screens/onboarding/onboarding_page.dart';
import 'package:pilates/theme/widgets/texts.dart';
import 'package:pilates/utils/paths/images.dart';
import 'package:pilates/utils/size_config.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});
  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final _globalKey = GlobalKey<ScaffoldState>();
  Texts texts = Texts();
  @override
  void initState() {
    super.initState();
    detectIsFirstOpen().then((isFirstOpen) {
      if (isFirstOpen) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const OnboardingPage(),
              ),
            );
          });
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            );
          });
        });
      }
    });
  }

  Future<bool> detectIsFirstOpen() async {
    //instanciar variable de hive
    Box onboardingBox = await Hive.openBox('onboardingBox');
    bool? isFirstOpen = onboardingBox.get('isFirstTime', defaultValue: true);
    if (isFirstOpen!) {
      onboardingBox.put('isFirstTime', false);
    }
    return isFirstOpen;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(25 * SizeConfig.heightMultiplier),
              ),
              clipBehavior: Clip.hardEdge,
              height: 20 * SizeConfig.heightMultiplier,
              child: Image.asset(
                images.logoRectangle,
                fit: BoxFit.scaleDown,
              ),
            ),
            SizedBox(height: 1 * SizeConfig.heightMultiplier),
            LoadingAnimationWidget.beat(
                color: const Color(0xFF1D1D1B),
                size: 5 * SizeConfig.heightMultiplier),
          ],
        ),
      ),
    );
  }
}
