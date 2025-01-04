import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/images_paths.dart';
import 'package:pilates/config/size_config.dart';
import 'package:pilates/theme/utils/custom_navigator.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});
  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  final _globalKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    detectIsFirstOpen().then((isFirstOpen) {
      if (isFirstOpen) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(const Duration(seconds: 3), () {
            customNavigator(context, '/onboarding');
          });
        });
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(const Duration(seconds: 3), () {
            customNavigator(context, '/login');
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
      backgroundColor: AppColors.white100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SizeConfig.scaleHeight(25)),
              ),
              clipBehavior: Clip.hardEdge,
              height: SizeConfig.scaleHeight(20),
              child: Image.asset(
                imagesPaths.logoRectangle,
                fit: BoxFit.scaleDown,
              ),
            ),
            SizedBox(height: SizeConfig.scaleHeight(1)),
            LoadingAnimationWidget.staggeredDotsWave(
                color: AppColors.black100, size: SizeConfig.scaleHeight(5)),
          ],
        ),
      ),
    );
  }
}
