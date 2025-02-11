import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pilates/common/logger.dart';
import 'package:pilates/theme/app_colors.dart';
import 'package:pilates/config/images_paths.dart';
import 'package:pilates/config/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool ifFirstTime = prefs.getBool('isFirstTime') ?? true;

        if (ifFirstTime) {
          await prefs.setBool('isFirstTime', false);
        }

        await Future.delayed(const Duration(seconds: 5), () {
          if (mounted) {
            context.go(ifFirstTime ? '/onboarding' : '/onboarding');
          }
        });
      } catch (e) {
        Logger.logAppError('Error en SplashScreenPage $e');
      }
    });
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
              color: AppColors.black100,
              size: SizeConfig.scaleHeight(5),
            ),
          ],
        ),
      ),
    );
  }
}
